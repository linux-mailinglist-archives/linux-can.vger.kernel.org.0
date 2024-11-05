Return-Path: <linux-can+bounces-1889-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B568D9BC8CD
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 10:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6C201C23635
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 09:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B45C01CEEB8;
	Tue,  5 Nov 2024 09:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyGUA7Xt"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCBF18F2F7
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 09:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730797993; cv=none; b=L3OgUAlvtVnu9sVGUFZXduk4ISYBYD/JSq83N8CW0jVMk9QvcZaInZRz77Y0Mg+p4XNETZO5bwIyrgVFI8YO5nKB0kJNsmlhqTsq7LXAJQReMhmk2Ka7ZxiOeWyIltDH/5QJ1oQhLPchqnBW18ojrvqqbwZUbWtripPntktyXzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730797993; c=relaxed/simple;
	bh=uiQ2JAhXPSStNeyqq5mL2G709mftQouH1+W/58MUBiQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gwtZqDng43F1IUlbJxoHk0U5g1p54swZ2VBk8LAhEmiEoVLSa7/o8Kk7QvYRyImuur4V2xHSI+Rn4iwEC/QzMpbddsh4/fdtRiuRqKk4lnLS9K+PxdqFbdjTYA0qYCvg7TvOzAezKILjK04v11TY5PjmsRKXoly39pV0+06vNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZyGUA7Xt; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2e3d523a24dso3984920a91.0
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2024 01:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730797991; x=1731402791; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkjVn9vxYfiyTYoSjdo6wZJS/fb5yrGuL1Y9+4PQuro=;
        b=ZyGUA7XtpwxlIAr6DRCG1s/8o32Crxl7AMJhWvxMmsID8YJCulUrUCCwE75NYJ5xbs
         P/RaNxg5/EzMQDeBP1W79XkDrJ8aLk1Dnubi+ePSyUWhAebk0cn+mnBVYRw0eiA59OZt
         OTp5+SijGvMbkGI+Q9uXTMYapDR0620DZsF2NbKhVYT4AhU6VJI0OC1K3q3Py4l/cnEi
         bg49C9xQo8JwDFbdXIbu3qw/EuDtUtquFFrk9RZs41qektmvFvZoMkoI4cve7J4D5jGm
         Cklq4aci9pCXowuNG9yhgHFWBTteMn0goMdZAdBLoaABT1pp3lHfIfF8BfiLJqKulv2P
         s57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730797991; x=1731402791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkjVn9vxYfiyTYoSjdo6wZJS/fb5yrGuL1Y9+4PQuro=;
        b=Z5lCPvdQLzHtLP+ZakpJtFirU2K/SPIVtAuYBoiNsrcpNhyvNxFM8x3urUgsnl+QRy
         7M5izTtewD+jDq+QekYl6aq9vnNGTFkjbNaOSYwnw9m8yD9mbUMK8lLNetugV6si4aLX
         HuIsLmsebyNzIcUycnutYzt3G+uvS4FQcTBzmm3M/w0xWsiQsKt2LROSWxO+wZn2pZ9l
         IxUxG7+OXFlYvCXFa2TNKyRRNFKVqXkExb8Eu8uViYGHR3bKSZsV2rihLG8CsMKCpWrl
         D6naQnYyKDQJ0QuGR+vm9CuuJjib1TybiSvhx0Y01t8zoiHZEBkW5ad1IlDjDpKUV0x/
         KJrQ==
X-Gm-Message-State: AOJu0YxHRZT4xI/1i6l+C3nqeeaU6MMJZyNHxmbpaS9FerOBMShOiH7x
	7Jtb2ER4A1/hkMBiRoTPTGtV1DDXVjKS5dA/uS8aPsews3y//MxYMJizfUVqcv0DwTbu2BJBlgp
	AL9IRs20Zvse+mxmDuYmkIer4zjQ=
X-Google-Smtp-Source: AGHT+IGgVwytkXPui17vaVxYdaHpTa4bCShFHwA2+H0h7RonnEiBW+MLnG7Fkm/a53HiLEUrqiOMFQDlJPDR8P0bx+4=
X-Received: by 2002:a17:90a:17ef:b0:2e7:8593:8365 with SMTP id
 98e67ed59e1d1-2e913714ee4mr30844275a91.5.1730797991516; Tue, 05 Nov 2024
 01:13:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
 <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com>
In-Reply-To: <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com>
From: Robert Nawrath <mbro1689@gmail.com>
Date: Tue, 5 Nov 2024 10:13:00 +0100
Message-ID: <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
Subject: Re: Missing CAN-XL XL data bit timing
To: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

@Vincent, thank you for the answer. Are there any plans to add the CAN
XL driver and the netlink interface for CAN XL?

I use the DCAN XL implemented in FPGA. I work for Digital Core Design
and it's one of our latest IP cores. I know the CAN-XL controller is a
rare product for now.

Best regards,

Robert Nawrath


On Fri, Nov 1, 2024 at 3:27=E2=80=AFPM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> +cc: Oliver
>
> On Thu. 31 Oct. 2024 at 20:55, Robert Nawrath <mbro1689@gmail.com> wrote:
> > Hi,
> > I'm working on a kernel module for CAN-XL device. I can see in
> > /linux/can/dev.h that there are structures and methods for setting
> > bittiming and data_bittiming. The bittiming refers to CAN nominal bit
> > time, data_bittiming refers to CAN data bit time (using ISO/FDIS
> > 11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
> > values: FD data bit rate and XL data bit rate. This values are
> > different and the device shall have separate configuration register
> > sets for them. So for separate configuration registers there shall be
> > separate methods and structs.
> > Am I right that the current implementation in kernel is incomplete? Or
> > am I missing something?
>
> Yes, you are right. There is not yet a netlink interface for CAN XL,
> mostly because there is not yet a CAN XL driver in linux-can and
> because, before you, no one manifested a need for this.
>
> @Oliver, in this message:
>
>   https://lore.kernel.org/linux-can/2540406e-8da3-4cb8-bd1a-30271dd6cc67@=
hartkopp.net/
>
> you mentioned that you were working on the bitrate configuration. Any
> update? Seems that this is time to make this live! I did some work on
> the netlink and the iproute2 tool in the past when I added the TDC, so
> eventually, I can help a bit if needed.
>
> @Robert, out of curiosity, what is the name of your CAN XL device?
>
>
> Yours sincerely,
> Vincent Mailhol
>
> Le jeu. 31 oct. 2024 =C3=A0 20:55, Robert Nawrath <mbro1689@gmail.com> a =
=C3=A9crit :
> >
> > Hi,
> > I'm working on a kernel module for CAN-XL device. I can see in
> > /linux/can/dev.h that there are structures and methods for setting
> > bittiming and data_bittiming. The bittiming refers to CAN nominal bit
> > time, data_bittiming refers to CAN data bit time (using ISO/FDIS
> > 11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
> > values: FD data bit rate and XL data bit rate. This values are
> > different and the device shall have separate configuration register
> > sets for them. So for separate configuration registers there shall be
> > separate methods and structs.
> > Am I right that the current implementation in kernel is incomplete? Or
> > am I missing something?
> > Robert
> >

