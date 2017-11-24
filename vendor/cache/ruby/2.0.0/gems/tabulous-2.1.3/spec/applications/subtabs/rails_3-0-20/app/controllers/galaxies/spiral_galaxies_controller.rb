class Galaxies::SpiralGalaxiesController < ApplicationController
  # GET /galaxies/spiral_galaxies
  # GET /galaxies/spiral_galaxies.xml
  def index
    @galaxies_spiral_galaxies = Galaxies::SpiralGalaxy.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @galaxies_spiral_galaxies }
    end
  end

  # GET /galaxies/spiral_galaxies/1
  # GET /galaxies/spiral_galaxies/1.xml
  def show
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @galaxies_spiral_galaxy }
    end
  end

  # GET /galaxies/spiral_galaxies/new
  # GET /galaxies/spiral_galaxies/new.xml
  def new
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @galaxies_spiral_galaxy }
    end
  end

  # GET /galaxies/spiral_galaxies/1/edit
  def edit
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.find(params[:id])
  end

  # POST /galaxies/spiral_galaxies
  # POST /galaxies/spiral_galaxies.xml
  def create
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.new(params[:galaxies_spiral_galaxy])

    respond_to do |format|
      if @galaxies_spiral_galaxy.save
        format.html { redirect_to(@galaxies_spiral_galaxy, :notice => 'Spiral galaxy was successfully created.') }
        format.xml  { render :xml => @galaxies_spiral_galaxy, :status => :created, :location => @galaxies_spiral_galaxy }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @galaxies_spiral_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /galaxies/spiral_galaxies/1
  # PUT /galaxies/spiral_galaxies/1.xml
  def update
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.find(params[:id])

    respond_to do |format|
      if @galaxies_spiral_galaxy.update_attributes(params[:galaxies_spiral_galaxy])
        format.html { redirect_to(@galaxies_spiral_galaxy, :notice => 'Spiral galaxy was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @galaxies_spiral_galaxy.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /galaxies/spiral_galaxies/1
  # DELETE /galaxies/spiral_galaxies/1.xml
  def destroy
    @galaxies_spiral_galaxy = Galaxies::SpiralGalaxy.find(params[:id])
    @galaxies_spiral_galaxy.destroy

    respond_to do |format|
      format.html { redirect_to(galaxies_spiral_galaxies_url) }
      format.xml  { head :ok }
    end
  end
end
