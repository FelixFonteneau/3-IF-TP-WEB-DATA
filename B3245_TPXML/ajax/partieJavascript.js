//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function recupererPremierEnfantDeTypeNode(n) {
    var x = n.firstChild;
    while (x.nodeType != 1) { // Test if x is an element node (and not a text node or other)
        x = x.nextSibling;
    }
    return x;
}
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//change le contenu de l'�lement avec l'id "nom" avec la chaine de caract�res en param�tre
function setNom(nom) {
    var elementHtmlARemplir = window.document.getElementById("id_nom_a_remplacer");
    elementHtmlARemplir.innerHTML = nom;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//charge le fichier XML se trouvant � l'URL relative donn� dans le param�treet le retourne
function chargerHttpXML(xmlDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    //chargement du fichier XML � l'aide de XMLHttpRequest synchrone (le 3� param�tre est d�fini � false)
    httpAjax.open('GET', xmlDocumentUrl, false);
    httpAjax.send();

    return httpAjax.responseXML;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Charge le fichier JSON se trouvant � l'URL donn�e en param�tre et le retourne
function chargerHttpJSON(jsonDocumentUrl) {

    var httpAjax;

    httpAjax = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject('Microsoft.XMLHTTP');

    if (httpAjax.overrideMimeType) {
        httpAjax.overrideMimeType('text/xml');
    }

    // chargement du fichier JSON � l'aide de XMLHttpRequest synchrone (le 3� param�tre est d�fini � false)
    httpAjax.open('GET', jsonDocumentUrl, false);
    httpAjax.send();

    var responseData = eval("(" + httpAjax.responseText + ")");

    return responseData;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton2_ajaxBibliographie(xmlDocumentUrl, xslDocumentUrl, newElementName) {

    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL � l'aide de XMLHttpRequest synchrone
    var xslDocument = chargerHttpXML(xslDocumentUrl);

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);

    // Chargement du fichier XML � l'aide de XMLHttpRequest synchrone
    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    // Cr�ation du document XML transform� par le XSL
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    // Recherche du parent (dont l'id est "here") de l'�l�ment � remplacer dans le document HTML courant
    var elementHtmlParent = window.document.getElementById("id_element_a_remplacer");
    // Premier �l�ment fils du parent
    var elementHtmlARemplacer = recupererPremierEnfantDeTypeNode(elementHtmlParent);
    // Premier �l�ment "elementName" du nouveau document (par exemple, "ul", "table"...)
    var elementAInserer = newXmlDocument.getElementsByTagName(newElementName)[0];

    // Remplacement de l'�l�ment
    elementHtmlParent.replaceChild(elementAInserer, elementHtmlARemplacer);

}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton3_ajaxEmployees(xmlDocumentUrl) {


    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    //extraction des noms � partir du document XML (avec une feuille de style ou en javascript)
    var lesNoms = xmlDocument.getElementsByTagName("LastName");

    // Parcours de la liste des noms avec une boucle for et
    // construction d'une chaine de charact�res contenant les noms s�par�s par des espaces
    // Pour avoir la longueur d'une liste : attribut 'length'
    // Acc�s au texte d'un noeud "LastName" : NOM_NOEUD.firstChild.nodeValue
    var chaineDesNoms = "";
    for (i = 0; i < lesNoms.length; i++) {
        if (i > 0) {
            chaineDesNoms = chaineDesNoms + ", ";
        }
        chaineDesNoms = chaineDesNoms + lesNoms[i].firstChild.nodeValue + " ";
    }


    // Appel (ou recopie) de la fonction setNom(...) ou bien autre fa�on de modifier le texte de l'�l�ment "span"
    setNom(chaineDesNoms);


}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton4_ajaxEmployeesTableau(xmlDocumentUrl, xslDocumentUrl) {
    //commenter la ligne suivante qui affiche la bo�te de dialogue!
    alert("Fonction � compl�ter...");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function setBackColor(color) {
    window.document.body.style.backgroundColor = color;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function setButtonColor(color) {
   window.document.getElementById('myButton4').style.color = color;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton3_ajaxCherchePays(xmlDocumentUrl, xslDocumentUrl, nomPays) {

    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XSL � l'aide de XMLHttpRequest synchrone
    var xslDocument = chargerHttpXML(xslDocumentUrl);

    // Importation du .xsl
    xsltProcessor.importStylesheet(xslDocument);

    // Chargement du fichier XML � l'aide de XMLHttpRequest synchrone
    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    // Cr�ation du document XML transform� par le XSL et set du param�tre
    xsltProcessor.setParameter(null, 'NomPays', window.document.getElementById('myText2').value);
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    var elementHtmlARemplacer = window.document.getElementById('textePays');

    var elementAInserer = newXmlDocument.getElementsByTagName(nomPays)[0];

    elementHtmlARemplacer.innerHTML = elementAInserer.innerHTML;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton4_ajaxExempleSVG(xmlDocumentUrl) {

    var xsltProcessor = new XSLTProcessor();

    // Chargement du fichier XML � l'aide de XMLHttpRequest synchrone
    var xmlDocument = chargerHttpXML(xmlDocumentUrl);

    var elementHtmlARemplacer = window.document.getElementById('exempleSVG');

    texteAInserer = new XMLSerializer().serializeToString(xmlDocument);

    elementHtmlARemplacer.innerHTML = texteAInserer;
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton5_ajaxExempleSVG() {
  var spanSVG = window.document.getElementById('lesFormes').getElementsByTagName('g')[0];
  var enfantSVG = spanSVG.children;
  for (var i = 0; i < enfantSVG.length; i++) {
    console.log(enfantSVG[i].getAttribute("title"));
    enfantSVG[i].addEventListener("click", modifierText);
  }
}


function modifierTextExemple() {
  var elementClicke = this;
  var spantitre = window.document.getElementById('titre');
  //console.log("bla");
  spantitre.innerHTML = this.getAttribute("title");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton6_ajaxCarteSVG(xmlDocumentUrl) {

  var xsltProcessor = new XSLTProcessor();

  // Chargement du fichier XML � l'aide de XMLHttpRequest synchrone
  var xmlDocument = chargerHttpXML(xmlDocumentUrl);

  var elementHtmlARemplacer = window.document.getElementById('carteSVG');

  texteAInserer = new XMLSerializer().serializeToString(xmlDocument);

  elementHtmlARemplacer.innerHTML = texteAInserer;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton7_ajaxCarteSVGClickable() {
  var spanCarteSVG = window.document.getElementById('carteSVG').getElementsByTagName('svg')[0].getElementsByTagName('g')[0];
  var enfantCarteSVG = spanCarteSVG.children;
  for (var i = 0; i < enfantCarteSVG.length; i++) {
    console.log(enfantCarteSVG[i].getAttribute("countryname"));
    enfantCarteSVG[i].addEventListener("click", modifierTextCarte);
  }
}

function modifierTextCarte() {
  var elementClicke = this;
  var spantitre = window.document.getElementById('nomDuPays');
  //console.log("bla");
  spantitre.innerHTML = this.getAttribute("countryname");
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
function Bouton8_ajaxCarteSVGMouseListen() {
  var spanCarteSVG = window.document.getElementById('carteSVG').getElementsByTagName('svg')[0].getElementsByTagName('g')[0];
  var enfantCarteSVG = spanCarteSVG.children;
  for (var i = 0; i < enfantCarteSVG.length; i++) {
    enfantCarteSVG[i].addEventListener("mouseover", modifierCarteOver);
    enfantCarteSVG[i].addEventListener("mouseleave", modifierCarteLeave);
  }
}

function modifierCarteOver() {
  var spantitre = window.document.getElementById('nomDuPays');
  var tab = window.document.getElementById('tabPays');
  //console.log("bla");
  this.style.fill = 'red';

  var test = true;
  var tabNomExistant  = window.document.getElementsByClassName('classNomPays');

    var xsltProcessor = new XSLTProcessor();
    var xslDocument = chargerHttpXML("ajax.bouton8.xsl");
    xsltProcessor.importStylesheet(xslDocument);
    var xmlDocument = chargerHttpXML("ajax.countriesTP.xml");
    xsltProcessor.setParameter(null, 'NomPays', this.getAttribute('countryname'));
    var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

    var elementHtmlARemplacer = window.document.getElementById('tabPays').getElementsByTagName('table')[0];

    var elementAInserer = newXmlDocument.getElementsByTagName('body')[0];

    elementHtmlARemplacer.innerHTML = elementAInserer.innerHTML;

}

function modifierCarteLeave() {
  var spantitre = window.document.getElementById('nomDuPays');
  //console.log("bla");
  this.style.fill = 'lightgrey';
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

function Bouton9(){
  //datalist
  var xsltProcessor = new XSLTProcessor();

  // Chargement du fichier XSL � l'aide de XMLHttpRequest synchrone
  var xslDocument = chargerHttpXML('ajax.nomPaysBouton9.xsl');

  // Importation du .xsl
  xsltProcessor.importStylesheet(xslDocument);

  // Chargement du fichier XML � l'aide de XMLHttpRequest synchrone
  var xmlDocument = chargerHttpXML('ajax.countriesTP.xml');

  // Cr�ation du document XML transform� par le XSL et set du param�tre
  var newXmlDocument = xsltProcessor.transformToDocument(xmlDocument);

  var tabNomPays =  newXmlDocument.getElementsByTagName('span');


  for (var i = 0; i < tabNomPays.length; i++) {
    var z = document.createElement("OPTION");
    z.setAttribute("value", tabNomPays[i].innerHTML);
    document.getElementById("dataliste").appendChild(z);
  }


}
