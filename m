Return-Path: <linux-can+bounces-2744-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD81AA2B7D0
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2025 02:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ED9216730A
	for <lists+linux-can@lfdr.de>; Fri,  7 Feb 2025 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCEC133987;
	Fri,  7 Feb 2025 01:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZSD/M9rB"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9964EAE7;
	Fri,  7 Feb 2025 01:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738891543; cv=none; b=t3KOvUt1qAr9oZO3m8cMNgdySrOV8ooE5EsDFSnTjSC2YGLkbBIsUbEVyL+9AOhHvtgnQ9rg6ZTT5gsX84PU7W0lZK/dYl6Ua8huP5zMss4FAY4FqchAP/xV0WhueF1PK8bylFc5LYtw0RdefR9gOGacZ+wQsgwOS7RtVKYxnvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738891543; c=relaxed/simple;
	bh=sFJcElIs9inuvVBkKm0vaV/Uz374UoJ0oUKxpMgoMe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0DnxfPoVU/g1TJgLVGoTI/ABXbjRps8UFN/KRVdSt6Pmi48lSq2COritwG7rShuSMkxwcZXtds9wNphoZdinatEJNsT+N4idHNGRDVUIRzIYRsxnavV7O1CU7BSY449XrA1B391BTyxwyb7RhQt0k6YNahfxor2ahYJuAD1KsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZSD/M9rB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2166360285dso28777745ad.1;
        Thu, 06 Feb 2025 17:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738891540; x=1739496340; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ521xbCbtnZrJbMQOX6yAoYlSkPj9bzoEtZpED1B3Q=;
        b=ZSD/M9rBP8puTWSoZrAj4eArlfYZJNydivEkfQ2ph12kHNuN5sDLRbDnO2/DAfDyrI
         XbWRq+Q+b3X5PAPkWAkoe6vo9I8r0maopQRr86Homy5ZohMcF1NW+JpTO6iP7oJTEHec
         D+7XF82wQYbSizmgKxklHrOEJvDWPJdyptqx9/jPTV1nH6cO2alz5SFUH3+eGCsPUqj3
         1MhQzJL4ilPV2zUtgbqB7CibIf0G+CxONP35CF00D9dYlMstow2UqEMACAbjHhC26+WX
         2sxZ29LHJ5HiqXPMwMxsaWAK6ODHHwujAwu6u45TX7D5UdErKZ3lcPhNwXfLkHZ3+Ny4
         u/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738891540; x=1739496340;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ521xbCbtnZrJbMQOX6yAoYlSkPj9bzoEtZpED1B3Q=;
        b=i1AE3pDuNNftgP8b2NiFvm0x+GDKwWlnYh3CQA1n0miOvj+P5TlhW/npQINs3nv3Q+
         kXtbXelfWKlj8O/vH9Id7gO+sUNtUMrb5RRnd35Ys4bhbxn4C4LLERSuph7rG4HlQinM
         iHh75+rZQUNXzdygnbNcpb0ZlcLKxJrb/S3Klp5gYCGC3lXLBBu7vspWNyDpZvu23uMU
         l9+SRjeiGfxA3FOqDBPkq4iB63K0g9DjnP8GbUcNjf1Cm57ajHSAeq/hfZnJPNtMd4t/
         eyFQiDkmHztzfVVk8YP1ep4PVfTqIawZ0DsbejpVP+RR5xF0Q0gfYrqltPQKzvyn1LNh
         z44A==
X-Forwarded-Encrypted: i=1; AJvYcCURBogDms/4E+IlGpAMB5KLjIzMVZuwpKI6ghiGVhqzpXIOrahcVAvPQrDeEa5wE0vDCSceFK9Zw0v4@vger.kernel.org, AJvYcCUsHKoYuPuWcVlS3gLWZRs5qn6nwED/ZdDu8ZqXXn2tdlpvF+MAD7JtJN5XScWUKrc5vxofQ3PUePZL@vger.kernel.org, AJvYcCW1woKJPk5Jhsx6FFjNK8ycYnINAXC1YJfyNjzpbuEDHnpz7ky2V3t08HGVmEnigglS8nQsa/csLCDheWt0@vger.kernel.org, AJvYcCWn9o637KObxFuo4Wq23IJKGNoZ1dtd3gvz6owWZS7hnrQvV8NxjrkvveQY/+FJHqiJEJVS+KWopCVQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzTSWYy4mJmaWXhqfcER77/wsMXyCWXxTm7BTmMFARFm+N0R8+H
	90PIBY3I+0fbczjNX7Id4+LDq2wTamx1tk8xe7WassGiFIo1xn7b
X-Gm-Gg: ASbGncvfEW84OCs7K2vmGuOgjpvslluQnUVdvMHF1Y7GRVVbKLh5/FV5Ofzeb7bUCK0
	MLeiEL4EB4raVY+bLfW8DovTznJYSao8LaXfWEzUKd/dEO87QioOe75nGp8Pr58gua3o3UWgySX
	IKpYQ3k1jv886cYJN5WMHGfYUQXVwW2sJjflbp5Qiqmn/+iQNUWETxw9IvgeuoKGoowuvzcZj7W
	M6Ln/in7op5uRN8n6mUdAUyJoyZDlM3BSL04Bf/PkIineN02f4Xe6Nu6gFuV5kEPzfsH72jHyvQ
	MkO3W2y2KagjZsI=
X-Google-Smtp-Source: AGHT+IGsg0qMRGMWWheXbon4Tyz5EgiQDLM6u29ig/fWJvk4CdczbH12ShfpJJRABLMGdKUOcyhVIQ==
X-Received: by 2002:a17:902:e848:b0:21f:4c8b:c513 with SMTP id d9443c01a7336-21f4e759fb8mr18094565ad.36.1738891539816;
        Thu, 06 Feb 2025 17:25:39 -0800 (PST)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3653af58sm19346165ad.70.2025.02.06.17.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 17:25:38 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id C90814208FB2; Fri, 07 Feb 2025 08:25:35 +0700 (WIB)
Date: Fri, 7 Feb 2025 08:25:35 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Charles Han <hanchunchao@inspur.com>
Cc: linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org, mkl@pengutronix.de,
	manivannan.sadhasivam@linaro.org, thomas.kopp@microchip.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	cem@kernel.org, djwong@kernel.org, corbet@lwn.net
Subject: Re: [PATCH] Documentation: Remove repeated word in docs
Message-ID: <Z6VhD9_0qt4yRV6N@archie.me>
References: <20250206091530.4826-1-hanchunchao@inspur.com>
 <e0aeefc5-bf01-42ab-91e4-e727d560c983@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SM1wTfYmCciv77Zi"
Content-Disposition: inline
In-Reply-To: <e0aeefc5-bf01-42ab-91e4-e727d560c983@wanadoo.fr>


--SM1wTfYmCciv77Zi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 06, 2025 at 07:56:36PM +0900, Vincent Mailhol wrote:
> On 06/02/2025 at 18:15, Charles Han wrote:
> > diff --git a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst b=
/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> > index 12aa63840830..994f9e5638ee 100644
> > --- a/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> > +++ b/Documentation/filesystems/xfs/xfs-online-fsck-design.rst
> > @@ -4521,7 +4521,7 @@ Both online and offline repair can use this strat=
egy.
> >  | For this second effort, the ondisk parent pointer format as original=
ly   |
> >  | proposed was ``(parent_inum, parent_gen, dirent_pos) =E2=86=92 (dire=
nt_name)``.  |
> >  | The format was changed during development to eliminate the requireme=
nt   |
> > -| of repair tools needing to to ensure that the ``dirent_pos`` field  =
     |
> > +| of repair tools needing to ensure that the ``dirent_pos`` field     =
  |
>=20
> This breaks the indentation of the pipe on the right.

Indeed because Sphinx spills out malformed table error:

Documentation/filesystems/xfs/xfs-online-fsck-design.rst:4479: ERROR: Malfo=
rmed table.
> <snipped>...
| For this second effort, the ondisk parent pointer format as originally   |
| proposed was ``(parent_inum, parent_gen, dirent_pos) =E2=86=92 (dirent_na=
me)``.  |
| The format was changed during development to eliminate the requirement   |
| of repair tools needing to ensure that the ``dirent_pos`` field       |
| always matched when reconstructing a directory.                          |
|                                                                          |
| There were a few other ways to have solved that problem:                 |
> <snipped>...=20

Hence I didn't see that historical sidebar in htmldocs output.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--SM1wTfYmCciv77Zi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZ6VhBgAKCRD2uYlJVVFO
o5kNAQCBHUuURzR/MDz0ENSahsvyaLDpGyuMG5CX95roWUGnAgEA4hI91+pBBPN5
UPQJozF1W1xzqTyIYxAAAjWDqvzeOAE=
=+OVQ
-----END PGP SIGNATURE-----

--SM1wTfYmCciv77Zi--

