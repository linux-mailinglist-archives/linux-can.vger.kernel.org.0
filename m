Return-Path: <linux-can+bounces-1900-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9769BCCB2
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 13:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 097311C20E1B
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C351D45FD;
	Tue,  5 Nov 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="fTiqjTbw"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9371C3025
	for <linux-can@vger.kernel.org>; Tue,  5 Nov 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730809676; cv=none; b=FLYDTv5KUd/D493jkteI95WbjXVmToDWl+CdeIbKjHFiJ4QGeLqfRoS5u0d+Ex2IR89A4xggQuuR5e0vYHQ1AucGjV1Vh+aOF3u6+CdrgCv79Ep/BMd7oy6dIcnyKFHUtgfnFwpjgwpqabi11QwdgFxmy7JuSiq1yN7Gal988sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730809676; c=relaxed/simple;
	bh=dUzFTc3Sm38RI1y86gei9q3NcyliTTDjdEJHdD94N7w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S6JhYdVttHsF+r+cCO7OAyHRHeIjmUGb3+MrL57YBwN/csIPnaCEUzArFPDzvtA7nRXDWwpcnb04zCjeKwsI9+KNMetJy+0+/z0uQv2PeApTRk7KW3aETLYzHaZjZdIlDsIO7VC6lcMstujOgQqU20w/TSQkXqGpahNgDhDKDb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=fTiqjTbw; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f41.google.com ([209.85.218.41])
	by smtp.orange.fr with ESMTPSA
	id 8IeutS3sEXwSE8IeutZ6L5; Tue, 05 Nov 2024 13:27:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1730809665;
	bh=dUzFTc3Sm38RI1y86gei9q3NcyliTTDjdEJHdD94N7w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=fTiqjTbwgW5db+/gXq/riV2k93LJzHYIycguhzOq2PpOjQ8M5qCm6b3MRw0RXAQtg
	 vgqzgH1e+vC2hu4N91guRoNaWVNEM2jSMRwVSPS0BUh5TIHtTtopk0wp+wYazxIHLH
	 SyDkI6rc/Yh5V8BcY2VWx119s604EAITm7OvnNgCed9C0ZPlKeQyfWe8MFX6BBhNpX
	 5iGs2uygpeZ5DTNkQm22qwxNY55GOxu487hh17GIW191mRJ8WHWdzwCeAJht5dy2XD
	 c8WoDSMtHyoCY8yVGVh2+rFIUitF8OYFX00nnYWkh+ZdgLHTry0oxyaj5Q9neaXtpn
	 RFQ91QgPUmeKA==
X-ME-Helo: mail-ej1-f41.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 05 Nov 2024 13:27:45 +0100
X-ME-IP: 209.85.218.41
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a9eb68e0bd1so79975666b.3
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2024 04:27:44 -0800 (PST)
X-Gm-Message-State: AOJu0YxuFZPltvIPFc7p+Wg40AVMMlLNWFRPrMXBRMoQI4/Il0BjOgyK
	fZVsfdO5IoCwgz1J41A5wvLBu2rshMD0h7PoqFFpXrp/nqFO5/WPp/T/jDqx/WYl/nND2YEIaUb
	u15LrYs/ZCEdbMKVONgZMG4obhoU=
X-Google-Smtp-Source: AGHT+IGI6ni8zd8fverB4lFctikvPPDzeDA0SVJPmIwMhzJ5456ehPPBk55coDs/GlAk/aqVs2a1PkXb/3elZ4wbwFg=
X-Received: by 2002:a17:907:3ea0:b0:a99:4ca4:4ff4 with SMTP id
 a640c23a62f3a-a9e654cff1amr936737366b.23.1730809664581; Tue, 05 Nov 2024
 04:27:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAEQ16vpxthctdrpv0kBKEZJA8VNYffjGGPBGBY93RmKDD49bAQ@mail.gmail.com>
 <CAMZ6Rq+9GO0-5BfauX73ReNTn2LzkZP04eGaybS6Vh+t3=Gmng@mail.gmail.com> <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
In-Reply-To: <CAEQ16vokv=Xq+0T=6=e3UMooa_jJYCW-zXWSMKVrRPnM1HoZJg@mail.gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Tue, 5 Nov 2024 21:27:33 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqJ_N7Z1Cyxr2dFhGcP8S8z4L2qUvt=ovnvz7HXuUGoQnQ@mail.gmail.com>
Message-ID: <CAMZ6RqJ_N7Z1Cyxr2dFhGcP8S8z4L2qUvt=ovnvz7HXuUGoQnQ@mail.gmail.com>
Subject: Re: Missing CAN-XL XL data bit timing
To: Robert Nawrath <mbro1689@gmail.com>
Cc: linux-can@vger.kernel.org, Oliver Hartkopp <socketcan@hartkopp.net>
Content-Type: text/plain; charset="UTF-8"

On Tue. 5 Nov. 2024 at 18:13, Robert Nawrath <mbro1689@gmail.com> wrote:
> @Vincent, thank you for the answer. Are there any plans to add the CAN
> XL driver and the netlink interface for CAN XL?

I do not have a CAN XL device, preventing me from working on this.
Technically speaking, it should be feasible to write a dummy driver to
test the flow between the userland and the kernel through the netlink
interface, but there was no priority to do this. If you can do the
testing, I think we should start to work on this.

But first, I would like to hear Oliver's feedback. Maybe he already
has something backing on this topic :)

> I use the DCAN XL implemented in FPGA. I work for Digital Core Design
> and it's one of our latest IP cores. I know the CAN-XL controller is a
> rare product for now.

Yes. I wish I could get one but I will probably wait a while for
technology to become more mature and the price to drop.

> Best regards,
>
> Robert Nawrath

