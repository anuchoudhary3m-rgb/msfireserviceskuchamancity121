import React from 'react';
import { Shield, Check, MapPin, Phone, MessageSquare } from 'lucide-react';

export interface ProprietorCardProps {
  name?: string;
  company?: string;
  location?: string;
  mobile?: string;
  serviceArea?: string;
  domain?: string;
  imageUrl?: string;
}

export const ProprietorCard: React.FC<ProprietorCardProps> = ({
  name = "Pro. MANOHAR LAL",
  company = "MS FIRE SERVICE INDUSTRIES",
  location = "SIKAR ROAD, KUCHAMAN CITY, RAJASTHAN",
  mobile = "6378647799",
  serviceArea = "Kuchaman City & Didwana",
  domain = "msfiresafetykuchamancity.com",
  imageUrl = "/manohar_lal_profile.png"
}) => {
  return (
    <div className="relative overflow-hidden rounded-2xl bg-white border border-slate-200 shadow-lg p-6 max-w-md mx-auto text-center font-sans transition-all hover:shadow-xl">
      {/* Top red/orange accent line */}
      <div className="absolute top-0 left-0 right-0 h-1.5 bg-gradient-to-r from-red-600 to-orange-500" />

      {/* Top Badge */}
      <div className="inline-flex items-center gap-1.5 px-4 py-1.5 rounded-full bg-red-50 text-red-600 text-xs font-bold tracking-wider uppercase border border-red-100 mb-4">
        <Shield className="w-3.5 h-3.5 fill-red-100 text-red-600" />
        <span>FIRE SAFETY PROPRIETOR</span>
      </div>

      {/* Profile Photo */}
      <div className="relative w-36 h-36 mx-auto mb-4">
        <img
          src={imageUrl}
          alt={`${name} - ${company}`}
          className="w-full h-full rounded-full object-cover border-4 border-white shadow-md"
        />
        <div
          className="absolute bottom-1 right-1 w-8 h-8 bg-green-600 text-white rounded-full flex items-center justify-center border-2 border-white shadow-sm"
          title="Verified Proprietor"
        >
          <Check className="w-4 h-4 stroke-[3]" />
        </div>
      </div>

      {/* Name */}
      <h3 className="text-xl font-extrabold text-slate-900 mb-1 tracking-tight">
        {name}
      </h3>

      {/* Company Name */}
      <p className="text-red-600 font-bold text-sm tracking-wide uppercase mb-1">
        {company}
      </p>

      {/* Location */}
      <p className="text-slate-500 text-xs font-medium flex items-center justify-center gap-1 mb-5">
        <MapPin className="w-3.5 h-3.5 text-red-600 shrink-0" />
        <span>{location}</span>
      </p>

      {/* Information Panel */}
      <div className="bg-slate-50 border border-slate-200 rounded-xl p-4 mb-5 text-left space-y-2.5 text-sm">
        <div className="flex justify-between items-center">
          <span className="text-slate-500 font-medium">Proprietor Name:</span>
          <span className="font-bold text-slate-900">{name}</span>
        </div>
        <div className="flex justify-between items-center">
          <span className="text-slate-500 font-medium">Direct Mobile:</span>
          <a
            href={`tel:+91${mobile}`}
            className="font-bold text-red-600 hover:underline"
          >
            {mobile}
          </a>
        </div>
        <div className="flex justify-between items-center">
          <span className="text-slate-500 font-medium">Service Location:</span>
          <span className="font-bold text-slate-900">{serviceArea}</span>
        </div>
        <div className="flex justify-between items-center">
          <span className="text-slate-500 font-medium">Domain / Web:</span>
          <a
            href={`https://${domain}`}
            target="_blank"
            rel="noopener noreferrer"
            className="font-bold text-blue-600 hover:underline break-all"
          >
            {domain}
          </a>
        </div>
      </div>

      {/* Action Buttons */}
      <div className="flex flex-wrap items-center justify-center gap-3">
        <a
          href={`https://wa.me/91${mobile}`}
          target="_blank"
          rel="noopener noreferrer"
          className="flex-1 min-w-[200px] inline-flex items-center justify-center gap-2 px-5 py-2.5 bg-green-600 hover:bg-green-700 text-white font-bold text-sm rounded-full shadow-md transition-all hover:-translate-y-0.5"
        >
          <MessageSquare className="w-4 h-4 fill-white" />
          <span>WhatsApp Manohar Lal</span>
        </a>
        <a
          href={`tel:+91${mobile}`}
          className="inline-flex items-center justify-center gap-1.5 px-5 py-2.5 bg-white hover:bg-red-600 text-red-600 hover:text-white border-2 border-red-600 font-bold text-sm rounded-full transition-all hover:-translate-y-0.5"
        >
          <Phone className="w-4 h-4" />
          <span>Call</span>
        </a>
      </div>
    </div>
  );
};

export default ProprietorCard;
