Return-Path: <linux-can+bounces-1859-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A29B9324
	for <lists+linux-can@lfdr.de>; Fri,  1 Nov 2024 15:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4FBC1F22C66
	for <lists+linux-can@lfdr.de>; Fri,  1 Nov 2024 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5C61FDF;
	Fri,  1 Nov 2024 14:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="hBuhFF2r"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D51BF24
	for <linux-can@vger.kernel.org>; Fri,  1 Nov 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730471275; cv=none; b=Vq2RlATtXN6pNY0IZ/dMHR5ktwUfn9qWCbTBcJ+NYEjsRAS59y7bUN9Q4Bn7qUMGIyqceeNcT4VcqTaDEIQuKpwSfVgZ4uvamSmj7nQqP3rTmxOmpXvDgmdWJb+VTU9YM02kQYABR2Q3qzbh30xhKuBFRf1Qxb0ADSK5henYhjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730471275; c=relaxed/simple;
	bh=prW1GYaVdkKPECe1xwRGf7Yg838u7favEAECs7lfWEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MebYLPxXFREexai8GhxIf8BrcRwYbqa3xeU7VDp883Aqc0EhiHrY98j8Nfj6OLYPsVKf+qw/Bs/mFmpITU9LOeZvIlNyWPnOXhyMhgc+vdjGm9/zU2XetHS0BlJSL9j436ZejeCyn00fsHcFWQd35PS2OALxizpp7bFfh45zZUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=hBuhFF2r; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by smtp.orange.fr with ESMTPSA
	id 6scst2j1zp5tl6scstZjKZ; Fri, 01 Nov 2024 15:27:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730471267;
	bh=6xNVBK+B8qhA79fB9fv+4IfN2lNHhMXrQ4ddhrZ08Mc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=hBuhFF2rErnP4evvSXH2Q0K6inwfA5a5/ESrINxoVD0NOUD0Do6DXFiuBs6ykBCrq
	 xRkyxrG3S9vVAUaRMBWaWn83ih12/+iD5hysSwFzTgwL48zTLVp1KoSKiPio5DeOXZ
	 9PhMTX7G0zXLyK6TJfDnAD1x5GLCHzNXkCgk6PNL7KqCUvVEFQpmQahx7MhJt5xfl4
	 CrIGpULQHP3dl5qOcJCvRxmFjx72kWhEeCE/95fzsrw7PzcekTshNLYozsPFpKG2hf
	 /E6zX+Op2nGfhllU6JH3h+Hbvt3qLqB3votA0k/aCYSmWb9ss7PTxDiM+YZjidX3tE
	 T5bkuFXyd2/+g==
X-ME-Helo: mail-ej1-f48.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Fri, 01 Nov 2024 15:27:47 +0100
X-ME-IP: 209.85.218.48
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a0c40849cso330776366b.3
        for <linux-can@vger.kernel.org>; Fri, 01 Nov 2024 07:27:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yysd7Dh17EpNzNLHrB9+7O6uG39eukC3JNoI4hH5N9WMLmIEFcM
	dGXdhwQPOKqPXFclHHjIXr2maHapnMJfgG886MYZelzrcetszBnM95foAe2sykFdZYYBYHtaPIu
	f/3H76zQupziVQm2zPGOn6lKB64s=
X-Google-Smtp-Source: AGHT+IGPlkiQSQcV7wgxgGqRPqB2cA/lPdwqQAGMc4+wz1D0m0a3xDJ3k4W29iLp2LO3s0LE6jTqjIrXx77sv9NBs5A=
X-Received: by 2002:a17:907:9625:b0:a9a:6ac3:92e with SMTP id
 a640c23a62f3a-a9e3a5a2884mr1098782766b.23.1730471266414; Fri, 01 Nov 2024
 07:27:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
In-Reply-To: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Fri, 1 Nov 2024 23:27:35 +0900
X-Gmail-Original-Message-ID: <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com>
Message-ID: <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com>
Subject: Re: Missing CAN-XL XL data bit timing
To: Robert Nawrath <mbro1689@gmail.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc: Oliver

On Thu. 31 Oct. 2024 at 20:55, Robert Nawrath <mbro1689@gmail.com> wrote:
> Hi,
> I'm working on a kernel module for CAN-XL device. I can see in
> /linux/can/dev.h that there are structures and methods for setting
> bittiming and data_bittiming. The bittiming refers to CAN nominal bit
> time, data_bittiming refers to CAN data bit time (using ISO/FDIS
> 11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
> values: FD data bit rate and XL data bit rate. This values are
> different and the device shall have separate configuration register
> sets for them. So for separate configuration registers there shall be
> separate methods and structs.
> Am I right that the current implementation in kernel is incomplete? Or
> am I missing something?

Yes, you are right. There is not yet a netlink interface for CAN XL,
mostly because there is not yet a CAN XL driver in linux-can and
because, before you, no one manifested a need for this.

@Oliver, in this message:

  https://lore.kernel.org/linux-can/2540406e-8da3-4cb8-bd1a-30271dd6cc67@ha=
rtkopp.net/

you mentioned that you were working on the bitrate configuration. Any
update? Seems that this is time to make this live! I did some work on
the netlink and the iproute2 tool in the past when I added the TDC, so
eventually, I can help a bit if needed.

@Robert, out of curiosity, what is the name of your CAN XL device?


Yours sincerely,
Vincent Mailhol

Le jeu. 31 oct. 2024 =C3=A0 20:55, Robert Nawrath <mbro1689@gmail.com> a =
=C3=A9crit :
>
> Hi,
> I'm working on a kernel module for CAN-XL device. I can see in
> /linux/can/dev.h that there are structures and methods for setting
> bittiming and data_bittiming. The bittiming refers to CAN nominal bit
> time, data_bittiming refers to CAN data bit time (using ISO/FDIS
> 11898-1:2024 nomenclature). But in CAN-XL the data bit rate has two
> values: FD data bit rate and XL data bit rate. This values are
> different and the device shall have separate configuration register
> sets for them. So for separate configuration registers there shall be
> separate methods and structs.
> Am I right that the current implementation in kernel is incomplete? Or
> am I missing something?
> Robert
>

