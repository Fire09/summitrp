Citizen.CreateThread(function()
  RequestIpl("gabz_pillbox_milo_")

  local interiorID = GetInteriorAtCoords(311.2546, -592.4204, 42.32737)

  if IsValidInterior(interiorID) then
    RemoveIpl("rc12b_fixed")
    RemoveIpl("rc12b_destroyed")
    RemoveIpl("rc12b_default")
    RemoveIpl("rc12b_hospitalinterior_lod")
    RemoveIpl("rc12b_hospitalinterior")
    RefreshInterior(interiorID)
  end
end)

Citizen.CreateThread(function()
  RequestIpl("gabz_import_milo_")
  
    interiorID = GetInteriorAtCoords(941.00840000, -972.66450000, 39.14678000)
    
    
  if IsValidInterior(interiorID) then
    --EnableInteriorProp(interiorID, "basic_style_set")
    --EnableInteriorProp(interiorID, "urban_style_set")		
    EnableInteriorProp(interiorID, "branded_style_set")
    EnableInteriorProp(interiorID, "car_floor_hatch")
    RefreshInterior(interiorID)
  end
end)

Citizen.CreateThread(function()


  RequestIpl("gabz_mrpd_milo_")
  
      interiorID = GetInteriorAtCoords(451.0129, -993.3741, 29.1718)
          
      
      if IsValidInterior(interiorID) then      
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm1")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm2")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm3")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm4")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm5")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm6")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm7")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm8")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm9")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm10")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm11")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm12")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm13")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm14")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm15")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm16")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm17")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm18")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm19")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm20")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm21")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm22")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm23")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm24")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm25")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm26")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm27")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm28")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm29")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm30")
              EnableInteriorProp(interiorID, "v_gabz_mrpd_rm31")
              
      RefreshInterior(interiorID)
  
      end
  
  end)

  local emitters = {
	
    "se_walk_radio_d_picked",
  }
  
  Citizen.CreateThread(function()
    for i = 1, #emitters do
      SetStaticEmitterEnabled(emitters[i], false)
    end
  end)

local autoexbbmin, autoexbbmax = vec3(517.3389, -226.6246, 49.33173), vec3(553.9767, -164.4719, 60.05186)
if not DoesScenarioBlockingAreaExist(autoexbbmin, autoexbbmax) then
  AddScenarioBlockingArea(autoexbbmin, autoexbbmax, 0, 1, 1, 1)
end

Citizen.CreateThread(function()
  SetMapZoomDataLevel(0, 0.96, 0.9, 0.08, 0.0, 0.0) -- Level 0
  SetMapZoomDataLevel(1, 1.6, 0.9, 0.08, 0.0, 0.0) -- Level 1
  SetMapZoomDataLevel(2, 8.6, 0.9, 0.08, 0.0, 0.0) -- Level 2
  SetMapZoomDataLevel(3, 12.3, 0.9, 0.08, 0.0, 0.0) -- Level 3
  SetMapZoomDataLevel(4, 24.3, 0.9, 0.08, 0.0, 0.0) -- Level 4
  SetMapZoomDataLevel(5, 55.0, 0.0, 0.1, 2.0, 1.0) -- ZOOM_LEVEL_GOLF_COURSE
  SetMapZoomDataLevel(6, 450.0, 0.0, 0.1, 1.0, 1.0) -- ZOOM_LEVEL_INTERIOR
  SetMapZoomDataLevel(7, 4.5, 0.0, 0.0, 0.0, 0.0) -- ZOOM_LEVEL_GALLERY
  SetMapZoomDataLevel(8, 11.0, 0.0, 0.0, 2.0, 3.0) -- ZOOM_LEVEL_GALLERY_MAXIMIZE
end)
