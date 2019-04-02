#!/local/bin/perl

#Ouverture des fichier d'entréé, filename = sortie de blast
my $filename = $ARGV[0];
my $ATclassfile = $ARGV[0];
#Ouverture des fichiers de sortie
my $output = $filename . ".xgmml";
open(OUT3, ">$output") || die "Could not create $output.\n";



open(IN, $filename) || die "Could not open $filename.\n";
open(DAT, $ATclassfile) || die "Could not open $filename.\n";
# utilisation des modules de perl et de bioperl, Bio::Searchio
# est le module de traitement de sortie de blast


#neconnaissance du format d'entree

#Debut du code proprement dit
$v=1; 
$u=1;
#Tant que on a une query, fait la suite du programme
	($ff, $changed_filename) = split('\\\\', $filename);
   ($outname1, $outname2, $outname3, $outname4, $outname5, $outname6, $outname7, $outname8, $outname9, $outname10) = split (//, $changed_filename);	
	$outname = join ('',$outname1,$outname2,$outname3,$outname4,$outname5,$outname6,$outname7);
	print "$outname1\n";
	print "$outname2\n";
	print "$outname3\n";
	print "$outname4\n";
	print "$outname5\n";
	print "$outname6\n";
	print "$outname7\n";
	
	my $output2 = $outname . ".xgmml";
open(OUT2, ">$output2") || die "Could not create $output.\n";
	print "$output2";
	
	seek (DAT, 0, 0);
	
print OUT3"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n";
print OUT3"<graph label=\"$changed_filename\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:cy=\"http://www.cytoscape.org\" xmlns=\"http://www.cs.rpi.edu/XGMML\"  directed=\"1\">\n";
print OUT3"  <att name=\"documentVersion\" value=\"1.1\"/>\n";
print OUT3"  <att name=\"networkMetadata\">\n";
print OUT3"    <rdf:RDF>\n";
print OUT3"      <rdf:Description rdf:about=\"http://www.cytoscape.org/\">\n";
print OUT3"        <dc:type>Protein-Protein Interaction</dc:type>\n";
print OUT3"        <dc:description>N/A</dc:description>\n";
print OUT3"        <dc:identifier>N/A</dc:identifier>\n";
print OUT3"        <dc:date>2010-10-07 10:15:20</dc:date>\n";
print OUT3"        <dc:title>$changed_filename</dc:title>\n";
print OUT3"        <dc:source>http://www.cytoscape.org/</dc:source>\n";
print OUT3"        <dc:format>Cytoscape-XGMML</dc:format>\n";
print OUT3"      </rdf:Description>\n";
print OUT3"    </rdf:RDF>\n";
print OUT3"  </att>\n";
	
print OUT2"<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>\n";
print OUT2"<graph label=\"$changed_filename\" xmlns:dc=\"http://purl.org/dc/elements/1.1/\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" xmlns:rdf=\"http://www.w3.org/1999/02/22-rdf-syntax-ns#\" xmlns:cy=\"http://www.cytoscape.org\" xmlns=\"http://www.cs.rpi.edu/XGMML\"  directed=\"1\">\n";
print OUT2"  <att name=\"documentVersion\" value=\"1.1\"/>\n";
print OUT2"  <att name=\"networkMetadata\">\n";
print OUT2"    <rdf:RDF>\n";
print OUT2"      <rdf:Description rdf:about=\"http://www.cytoscape.org/\">\n";
print OUT2"        <dc:type>Protein-Protein Interaction</dc:type>\n";
print OUT2"        <dc:description>N/A</dc:description>\n";
print OUT2"        <dc:identifier>N/A</dc:identifier>\n";
print OUT2"        <dc:date>2010-10-07 10:15:20</dc:date>\n";
print OUT2"        <dc:title>$changed_filename</dc:title>\n";
print OUT2"        <dc:source>http://www.cytoscape.org/</dc:source>\n";
print OUT2"        <dc:format>Cytoscape-XGMML</dc:format>\n";
print OUT2"      </rdf:Description>\n";
print OUT2"    </rdf:RDF>\n";
print OUT2"  </att>\n";	
	
	
	
	
	
	while ($ligne = <DAT>) {
	if($ligne =~ "<celldesigner:speciesAlias"){
	($TC, $ID, $Gen, $species) = split (/"/, $ligne);

	$u=$u+1;


		while ($ligne = <DAT>) {
			if($ligne =~ "<celldesigner:bounds x="){
			($bad, $x, $bad5, $y, $bad6, $w, $bad7, $h) = split (/"/, $ligne);
			last;
			}
			
		}
		
		while ($line = <IN>) {
		
			if($line =~ "<species metaid=\"$species\""){
			($bad, $bad20, $bad21, $name, $bad21, $label, $bad23, $bad22,$badx25) = split (/"/, $line);
			#print "$line";
				while ($line = <IN>) {
				
					if($line =~ "<celldesigner:class>"){
					
					($bad2, $splitx, $bad3) = split (/>/, $line);
					($type, $bad4) = split (/</, $splitx);
					last;
					}				
				}			
			}		
		}
		seek (IN, 0, 0);
		print OUT3"	<node label=\"$label\" id=\"$species\">\n";
		print OUT3"	<att type=\"string\" name=\"CELLDESIGNER_ALIAS\" value=\"$ID\"/>\n";
		print OUT3"	<att type=\"string\" name=\"CELLDESIGNER_SPECIES\" value=\"$species\"/>\n";
		print OUT3"  <att type=\"string\" name=\"CELLDESIGNER_NODE_TYPE\" value=\"$type\"/>\n";

		print OUT2"	<node label=\"$label\" id=\"$species\">\n";
		print OUT2"	<att type=\"string\" name=\"CELLDESIGNER_ALIAS\" value=\"$ID\"/>\n";
		print OUT2"	<att type=\"string\" name=\"CELLDESIGNER_SPECIES\" value=\"$species\"/>\n";
		print OUT2"  <att type=\"string\" name=\"CELLDESIGNER_NODE_TYPE\" value=\"$type\"/>\n";


					if($type =~ "GENE"){
					$shape = "RECT";
					}
					if($type =~ "RNA"){
					$shape = "PARALLELOGRAM";
					}
					if($type =~ "PROTEIN"){
					$shape = "OCTAGON";
					}
					if($type =~ "SIMPLE_MOLECULE"){
					$shape = "ELLIPSE";
					}
					
					if($type =~ "ION"){
					$shape = "DIAMOND";
					}
					if($type =~ "PHENOTYPE"){
					$shape = "ROUND_RECT";
					}

print OUT3"<graphics type=\"$shape\" h=\"$h\" w=\"$w\" x=\"$x\" y=\"$y\" fill=\"#ffffff\" width=\"1\" outline=\"#000000\" cy:nodeTransparency=\"1.0\" cy:nodeLabelFont=\"Default-0-12\" cy:borderLineType=\"solid\"/>\n";
print OUT3"</node>\n";
	
print OUT2"<graphics type=\"$shape\" h=\"$h\" w=\"$w\" x=\"$x\" y=\"$y\" fill=\"#ffffff\" width=\"1\" outline=\"#000000\" cy:nodeTransparency=\"1.0\" cy:nodeLabelFont=\"Default-0-12\" cy:borderLineType=\"solid\"/>\n";
print OUT2"</node>\n";	
	}
	
	
	
	
	
	
	
	if($ligne =~ "<celldesigner:complexSpeciesAlias"){
	($TC, $ID, $Gen, $species) = split (/"/, $ligne);

	$u=$u+1;


		while ($ligne = <DAT>) {
			if($ligne =~ "<celldesigner:bounds x="){
			($bad, $x, $bad5, $y, $bad6, $w, $bad7, $h) = split (/"/, $ligne);
			last;
			}
			
		}
		
		while ($line = <IN>) {
		
			if($line =~ "<species metaid=\"$species\""){
			($bad, $bad20, $bad21, $name, $bad21, $label, $bad23, $bad22,$badx25) = split (/"/, $line);
			
				while ($line = <IN>) {
					if($line =~ "<celldesigner:class>"){
					($bad2, $splitx, $bad3) = split (/>/, $line);
					($type, $bad4) = split (/</, $splitx);
					last;
					}				
				}			
			}		
		}
		seek (IN, 0, 0);
		print OUT3"	<node label=\"$name\" id=\"$species\">\n";
		print OUT3"	<att type=\"string\" name=\"CELLDESIGNER_ALIAS\" value=\"$ID\"/>\n";
		print OUT3"	<att type=\"string\" name=\"CELLDESIGNER_SPECIES\" value=\"$species\"/>\n";
		print OUT3"  <att type=\"string\" name=\"CELLDESIGNER_NODE_TYPE\" value=\"$type\"/>\n";
					
		print OUT2"	<node label=\"$name\" id=\"$species\">\n";
		print OUT2"	<att type=\"string\" name=\"CELLDESIGNER_ALIAS\" value=\"$ID\"/>\n";
		print OUT2"	<att type=\"string\" name=\"CELLDESIGNER_SPECIES\" value=\"$species\"/>\n";
		print OUT2"  <att type=\"string\" name=\"CELLDESIGNER_NODE_TYPE\" value=\"$type\"/>\n";					


print OUT3"<graphics type=\"$shape\" h=\"$h\" w=\"$w\" x=\"$x\" y=\"$y\" fill=\"#ffffff\" width=\"1\" outline=\"#000000\" cy:nodeTransparency=\"1.0\" cy:nodeLabelFont=\"Default-0-12\" cy:borderLineType=\"solid\"/>\n";

print OUT3"</node>\n";
print OUT2"<graphics type=\"$shape\" h=\"$h\" w=\"$w\" x=\"$x\" y=\"$y\" fill=\"#ffffff\" width=\"1\" outline=\"#000000\" cy:nodeTransparency=\"1.0\" cy:nodeLabelFont=\"Default-0-12\" cy:borderLineType=\"solid\"/>\n";

print OUT2"</node>\n";	
	
	}
	
		if($ligne =~ "<reaction metaid="){
		$iscat="0";
		($bad8, $reactionID, $bad9, $bad10) = split (/"/, $ligne);
		}
		if($ligne =~ "<celldesigner:reactionType>"){
		($bad11, $splitreact, $bad12) = split (/>/, $ligne);
		($react, $bad13) = split (/</, $splitreact);
		}
		if($ligne =~ "<celldesigner:baseReactant species"){
		($bad13, $reactantID, $bad14, $reactantalias, $bad15) = split (/"/, $ligne);
		}
		if($ligne =~ "<celldesigner:baseProduct species"){
		($bad13, $productID, $bad14, $productalias, $bad15) = split (/"/, $ligne);
		
		}
		if($ligne =~ "<celldesigner:reactantLink reactant"){
		($bad13, $reactant2ID, $bad14, $reactant2alias, $bad15) = split (/"/, $ligne);
		}
		if($ligne =~ "<celldesigner:productLink product"){
		($bad13, $product2ID, $bad14, $product2alias, $bad15) = split (/"/, $ligne);
		
		}
	
	
	
		if($ligne =~ "<celldesigner:modification type="){
		($bad16, $bad17, $bad18, $enzyme, $bad19) = split (/"/, $ligne);
		print OUT3"	<node label=\"$reactionID\" id=\"$reactionID\">\n";
		print OUT2"	<node label=\"$reactionID\" id=\"$reactionID\">\n";
						seek (IN, 0, 0);
						while ($line = <IN>) {
							if($line =~ "<celldesigner:speciesAlias id=\"$reactantalias\""){
								while ($line = <IN>) {
								if($line =~ "<celldesigner:bounds x="){
								($bad, $x, $bad5, $y, $bad6, $w, $bad7, $h) = split (/"/, $line);
						#print OUT3"$x\n";			
								last;
							
								}
								
								}last;
							}		
						}
						seek (IN, 0, 0);
						while ($line = <IN>) {
							if($line =~ "<celldesigner:speciesAlias id=\"$productalias\""){
								while ($line = <IN>) {
								if($line =~ "<celldesigner:bounds x="){
								($bad, $x2, $bad5, $y2, $bad6, $w2, $bad7, $h2) = split (/"/, $line);
								last;
								}
								}last;
							}		
						}
						seek (IN, 0, 0);
						$x3=($x+$x2)/2;
						$y3=($y+$y2)/2;
						
		print OUT3"<graphics type=\"TRIANGLE\" h=\"10\" w=\"10\" x=\"$x3\" y=\"$y3\" fill=\"#ffffff\" width=\"1\" outline=\"#000000\" cy:nodeTransparency=\"1.0\" cy:nodeLabelFont=\"Default-0-12\" cy:borderLineType=\"solid\"/>\n";
		print OUT3"  <att type=\"string\" name=\"CELLDESIGNER_NODE_TYPE\" value=\"STATE_TRANSITION\"/>\n";				
		print OUT3"</node>\n";

		print OUT3"<edge label=\"left$reactionID\" source=\"$reactantID\" target=\"$reactionID\">\n";
		print OUT3"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT3" </edge>\n";
		
		print OUT3"<edge label=\"right$reactionID\" source=\"$reactionID\" target=\"$productID\">\n";
		print OUT3"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT3" </edge>\n";
		if($reactant2ID ne ""){
		print OUT3"<edge label=\"left2$reactionID\" source=\"$reactant2ID\" target=\"$reactionID\">\n";
		print OUT3"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT3" </edge>\n";
		}
		if($product2ID ne ""){
		print OUT3"<edge label=\"right2$reactionID\" source=\"$reactionID\" target=\"$product2ID\">\n";
		print OUT3"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT3" </edge>\n";
		}
		print OUT3"<edge label=\"cat$reactionID\" source=\"$enzyme\" target=\"$reactionID\">\n";
		print OUT3"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"CATALYSIS\"/>\n";
		print OUT3" </edge>\n";

		print OUT2"<graphics type=\"TRIANGLE\" h=\"10\" w=\"10\" x=\"$x3\" y=\"$y3\" fill=\"#ffffff\" width=\"1\" outline=\"#000000\" cy:nodeTransparency=\"1.0\" cy:nodeLabelFont=\"Default-0-12\" cy:borderLineType=\"solid\"/>\n";
		print OUT2"  <att type=\"string\" name=\"CELLDESIGNER_NODE_TYPE\" value=\"STATE_TRANSITION\"/>\n";				
		print OUT2"</node>\n";

		print OUT2"<edge label=\"left$reactionID\" source=\"$reactantID\" target=\"$reactionID\">\n";
		print OUT2"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT2" </edge>\n";
		
		print OUT2"<edge label=\"right$reactionID\" source=\"$reactionID\" target=\"$productID\">\n";
		print OUT2"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT2" </edge>\n";
		if($reactant2ID ne ""){
		print OUT2"<edge label=\"left2$reactionID\" source=\"$reactant2ID\" target=\"$reactionID\">\n";
		print OUT2"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT2" </edge>\n";
		}
		if($product2ID ne ""){
		print OUT2"<edge label=\"right2$reactionID\" source=\"$reactionID\" target=\"$product2ID\">\n";
		print OUT2"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"STATE_TRANSITION\"/>\n";
		print OUT2" </edge>\n";
		}
		print OUT2"<edge label=\"cat$reactionID\" source=\"$enzyme\" target=\"$reactionID\">\n";
		print OUT2"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"CATALYSIS\"/>\n";
		print OUT2" </edge>\n";
		
		

		$enzyme="";
		$reactant2ID="";
		$product2ID="";
		$iscat="1";
		}
	
					if($ligne =~ "</reaction>"){
	
						if($iscat =~ "0"){
						
						
	print OUT3"<edge label=\"$reactionID\" source=\"$reactantID\" target=\"$productID\">\n";
		print OUT3"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"$react\"/>\n";
		#print OUT3"<graphics width=\"1\" fill=\"#000000\" cy:sourceArrow=\"0\" cy:targetArrow=\"1\" cy:sourceArrowColor=\"#000000\" cy:targetArrowColor=\"#000000\" cy:edgeLabelFont=\"SanSerif-0-10\" cy:edgeLineType=\"SOLID\" cy:curved=\"STRAIGHT_LINES\"/>\n";
		print OUT3" </edge>\n";
		
			print OUT2"<edge label=\"$reactionID\" source=\"$reactantID\" target=\"$productID\">\n";
		print OUT2"<att type=\"string\" name=\"CELLDESIGNER_EDGE_TYPE\" value=\"$react\"/>\n";
		#print OUT2"<graphics width=\"1\" fill=\"#000000\" cy:sourceArrow=\"0\" cy:targetArrow=\"1\" cy:sourceArrowColor=\"#000000\" cy:targetArrowColor=\"#000000\" cy:edgeLabelFont=\"SanSerif-0-10\" cy:edgeLineType=\"SOLID\" cy:curved=\"STRAIGHT_LINES\"/>\n";
		print OUT2" </edge>\n";
							}
	
					}
	
	
	
	}
	print OUT3"</graph>\n";
	print OUT2"</graph>\n";