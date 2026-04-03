Return-Path: <linux-can+bounces-7331-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7UajHw9Gz2lEuwYAu9opvQ
	(envelope-from <linux-can+bounces-7331-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 06:46:07 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E6864390F60
	for <lists+linux-can@lfdr.de>; Fri, 03 Apr 2026 06:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18075302A7E6
	for <lists+linux-can@lfdr.de>; Fri,  3 Apr 2026 04:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59AC358375;
	Fri,  3 Apr 2026 04:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DidQGWOK"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCB735836B
	for <linux-can@vger.kernel.org>; Fri,  3 Apr 2026 04:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775191563; cv=pass; b=HjDiFtk5mAwHTVEV+CxAySOFFBJekrQxWjf7NKd6dggHa1qY49gNDgtv7l+yzoVdaGEr4IVlUcXRemZ8A/sK1TEPrIg4SZ32BcuT6KxW8mvS790whT/BYwupLulb+V6ZytTvkZUNSKEPmBbQaroPSj6Tq7hiTpzP8GjJ/5l3PmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775191563; c=relaxed/simple;
	bh=groc3VAnH15CVUVhNhE5OtlEsDNXM/uA7VeW8vaOMTY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ACKaTnYAYBS/uu9YyUTU+ecdfLe7YBKDq3PjSyb2EROa0xzcLAq3phmJ13Nq6Pxux0f45eHXaOf3kHY3vG/nauUOxQ5vrO9PmQzMHvDfTPFboLV+v9GxpMopFBdHxozB+H5EvvWu/whn4l+13uYk2nLQeF7pB7ejVcEXaej8I5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DidQGWOK; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79a46260385so14859697b3.3
        for <linux-can@vger.kernel.org>; Thu, 02 Apr 2026 21:46:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775191561; cv=none;
        d=google.com; s=arc-20240605;
        b=BeMiyKpSbVK9NLvNdgnoDB+50WYY1jOEExEhhNiS9sO473Rcd/Ag1VTPqjTaK0b338
         fD91fHZyajUcCnYdYflEr+hJZWiv9hI8uAGKrlwvbAOljfCI1JINfsts+PstxdanHi0o
         4Vdpu+F9ZaDZY6IkZecw7GsOansgsy80Xq1RywZUI5nHe14v7bqOc9XnBMlcvt0PhI/S
         j3apLk/ITHgsC2ODj6F5pJ6So0TwNm1kpx0faiPqtETdgJ7QBzvH0URiGDxjay/NbsUl
         Kh5JR09+YLfhk8OgAbnmZBSBSxI/k7wcVCT3gzvLvgjLdkU5BGyCksZt5CAMnUq2fxTs
         6PKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        fh=7pDx58D6rRLKkHezWLQa0Wh6LEanh8Ub8uRlZPAZw1I=;
        b=UVRJJwTagk+kPKN8/VJ+UGhw16XhUw+9LUIH/G2mqxudP25QH92ggZSIh9pdc7Vt96
         5O9KSq4CTt6P7w95WEehkn1pzfjcmfHp6uCpKvTGOtGmlPKaQDfiTNhqN918fktKophw
         LAg41Bhk/Onh3sUckTHIAOFsrht5AyVfcefmrbOm++RlJwCzSxQUki7u1AXLD4M/+vY/
         0nOEQxPKTaIZ2YWdA6q1u+g8Afa40dRFRSrOImBqgYyAd50tbrkJ4IDBNfxMWFBawpiG
         EErbwgbkgfRkF3RnoIj71LP2NFgG5fg0Q7taYF45kAE+y1lqYQ9qyY2iYHG5n8aGhhi1
         H6kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775191561; x=1775796361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        b=DidQGWOKrm72zYGNfTnKQ9IcnJWZNioKN73o236MElVFzyQKQ8qb/l+soctZqFpFYR
         KhdKkKO4KWfPBZssLoFqJJaoQDXfr0ubxMRtcYnbkp4Aw6n+hEGhzMD/e6M1vs9Vctn7
         F7uzUA9y1Hc8Am0AiyTcsudzX2bQmqDVaIRAHRwR1H1Mdwqeulzb+nkNolrXNE6n+lnA
         5zZ6mhLg+931xo6+ZY56HBf57G3FpKAkbPbK1guAlEH/oool84UFse8KKG4/MulU3zjW
         kOZ0D+JZfXdmrH7t4ojZVoyu6NPL6R7//xVc/4ow33xoSCayriKVfXDNF+A2xeU4fM2L
         OvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775191561; x=1775796361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=udWmikDfTPoYOznLAWVnBq6+fVtMa2LFJrslNkdcn48=;
        b=NMDDbkEZziZsYgmT1a5WF7+epEToLHQHQkQkkuSvYfkJACyiJmFbL7q9/eyRkhS6hN
         QeCqMy93z2HjRISr/Gy1f+scU1dS9J6Nb1PqqSf5kr2v2h6CHvO2EqkHHNHEm5cTkWYL
         vwh9iLYYJ6b8K2mnkx7DRHaiI22J7BjAfsotCU4ErmF/Ku5In3DvJDN+4f0LLrBtJs90
         hKdTcdmEUaQmE4qpHPc9uOZ0evEWdJNwDF0JLzSzKLw53N0YWj8pyR5NsFEh2RIAJQH+
         aTHH07wCTJ/xw3/zIQL1CPPfQzGpQPOWKY0GQsep1bNGgFaQjDTigCQbadcWoaaWlwEN
         k8fQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7IvVRFnr7/8SHs8wQbxEjSlCOET40cMFrypIQho78vMyS4qTgQg2MZZlAX0V+8EeUapZeU+p4OVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KXquyP93kY+lUiQ1eSfquT1OIfRb57eHCZWGlERypVllC1/x
	R5sJ1rkoYlnpd3svwgz7AhqvsAyebXiBW3WTVqkCQX4NH0TEe0s5urbVx6TlyGhsvyhgopvV4v8
	Fetdi7c8HK6xA3Lz1eA142zv6Ag92eHc=
X-Gm-Gg: AeBDiete8Nn0tbnW3hvGyU1gO2XbpldJLQZaQqEP9NcmH6lMlXChkm0aoD6t/OqlfCu
	mA1VHkSht/i3qattb5Ky3CGjcOjm3odiBFmji1z1w7wFacAbko1zh8xvdlLPJzLqXCiBqmzTfWr
	QtjJX1HInPQoAyFR2R3H3HQBlOWyB4k14dVfMlF/wCDJ/nKkeJVN1ZkIDVVbT7Sd33+AWEHZ2Uj
	VG6z4FG7APxyJ6+wBlnxto1DScnPkgtlIUQobrstP7sGLwzPe6loifiiZbEBiBvapu+6MAI5npI
	kfCCNQ==
X-Received: by 2002:a05:690c:6987:b0:799:198d:8c5a with SMTP id
 00721157ae682-7a4d585f69dmr19958067b3.34.1775191561252; Thu, 02 Apr 2026
 21:46:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402051442.1426672-1-a0282524688@gmail.com>
 <20260402051442.1426672-3-a0282524688@gmail.com> <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
In-Reply-To: <20260402-warping-chameleon-of-prowess-9df780-mkl@pengutronix.de>
From: Ming Yu <a0282524688@gmail.com>
Date: Fri, 3 Apr 2026 12:46:22 +0800
X-Gm-Features: AQROBzC_c6Pz91vTEwJZ5AXR_5dXzfojiP7V5Wmo6LnqG_6F9RBzJL09w08myjU
Message-ID: <CAOoeyxVp2dY=XrujkCbWHjX4bVu4-H2=k0JHxL6akC6KwY+rVA@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] mfd: Add Host Interface (HIF) support for Nuvoton NCT6694
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: tmyu0@nuvoton.com, linusw@kernel.org, brgl@kernel.org, linux@roeck-us.net, 
	andi.shyti@kernel.org, lee@kernel.org, mailhol@kernel.org, 
	alexandre.belloni@bootlin.com, wim@linux-watchdog.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-i2c@vger.kernel.org, linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	linux-watchdog@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7331-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0282524688@gmail.com,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-can];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E6864390F60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear Marc,

Thanks for the review.

Marc Kleine-Budde <mkl@pengutronix.de> =E6=96=BC 2026=E5=B9=B44=E6=9C=882=
=E6=97=A5=E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:05=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> > +struct nct6694_sio_data {
> > +     enum nct6694_chips chip;
> > +     int sioreg;     /* Super-I/O index port */
> > +
> > +     /* Super-I/O access functions */
> > +     int (*sio_enter)(struct nct6694_sio_data *sio_data);
> > +     void (*sio_exit)(struct nct6694_sio_data *sio_data);
> > +     void (*sio_select)(struct nct6694_sio_data *sio_data, int ld);
> > +     int (*sio_inb)(struct nct6694_sio_data *sio_data, int reg);
> > +     int (*sio_inw)(struct nct6694_sio_data *sio_data, int reg);
> > +     void (*sio_outb)(struct nct6694_sio_data *sio_data, int reg, int =
val);
>
> The signatures of the function look a bit strange. I expect functions
> reading/writing bytes use u8 not int, register offsets should probably
> be an unsigned int.
>
> Why do you have pointers to the access functions? Why not use them
> directly?
>

These helpers were originally meant to be used by sub-drivers for SIO
access, but the implementation later converged so that all SIO access
is done in the MFD driver itself. In the next version, I will remove
the function pointers and simplify the interface accordingly.

I will also adjust the types as suggested.


Regards,
Ming

