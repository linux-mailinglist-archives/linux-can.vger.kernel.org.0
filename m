Return-Path: <linux-can+bounces-5450-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B186BC619F9
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 18:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F13B3B3796
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 17:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C9D30FC25;
	Sun, 16 Nov 2025 17:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEGwZjgH"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667C030F7FE
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 17:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763315412; cv=none; b=TTYl0N7YRCmYqxjUG/ry2lqa/aweQ9Y93g2UPSPO7Irsm1fVLg162/wUG4DyknR7yUOyYVdbcoGrv+V9zjOk9Jc+I3wn3u4sCN5v8//nvvi+/FUVqF0dazPAh05JEogA/5dlvhlGGI7x2P9J/EFSMpI148jEDq69+Sz2ozTb3Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763315412; c=relaxed/simple;
	bh=QP7jspNMzyTvkGv06BWTHIjJjU1oOmLPoesgjcHxeRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dG4Iek/gHa4iT4N/qY9p+ToMjuf9CTMhaWimyIQT1Wkv0DBQ37OyRIoA4cKjGRObmDxiPCRMP7yT+8IN40d9ba+mNay2CBmIUshriEzGgAq0YX2gVDmhgqs4LD/joC+w+scCXgFX8SGStNBFk+Eaz28j6rRY82bMWtdBH25hYBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEGwZjgH; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73669bdcd2so427069166b.2
        for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 09:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763315409; x=1763920209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QP7jspNMzyTvkGv06BWTHIjJjU1oOmLPoesgjcHxeRo=;
        b=cEGwZjgHJrnW5n6GJ5zi0t6emQHqYc2EN7FzgHa7VOIpWYCgV/XkSKH6f+myoOgy7a
         QKABIKtnd6EQXdlnZBZgTKndkhn/wRUg5ZhbMJyB4toXaWi4wbwdi+aly3cKfyFbxozo
         rQ4iCzm0F4K0OedHm9IQtIxvzfEIoVzhT89QCX3Qf7CLRdKLDnYxZwt7DEdSC8pXqEHb
         OixieAAeRrcUj6aoLu6eXr5aGropaZU8HLNcDhNPxIyn4R2YMYfJpI18B26kvkgCQ/Z+
         GqQXAf8Dr7R+bm4+T2nXllCUa6RcK/Mre7VZ7vdM6E8lPyv9vRzJJYD9GLoBO/LDPvaE
         AcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763315409; x=1763920209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QP7jspNMzyTvkGv06BWTHIjJjU1oOmLPoesgjcHxeRo=;
        b=He2G9ludxc7/NaudVUHFdtjLWEG2bXIIs/uyh2GcOhpqxALG76yHm/o8Hog26aEzu5
         iJOxz82kAst5TFuIiRMXfk8w/17nexYyLe+uaGAksWjC1qz3KSjRbYUdgRS1R0otqGoo
         1W4A4zUbWyeSEY+N+fZcZ+Za57XwtWyL6WjPPiuU0Mc81ax1kNJbI7emxJjjC9ApDIz/
         6YJhDRKMZhearP9nxBZRi1uMEWZHhAwY3sdmx3MbKNyFtfwUvzxPdh08fA3pJb3ZYa2Z
         qYnI3y10aoJKKPfYZGXcNAsMCQpUdtFdfc9SfcWWy6L4FDx2hnoVTtO193ZDarOzLWIM
         x2ew==
X-Forwarded-Encrypted: i=1; AJvYcCXx1Q+SuVmawh7t8L4+h06uDTmcvLnoGg1+JFQu2hKEsi8f2l2WGZZESWEN8t1vItYWir7WyTtaE1A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yzcMmfuxaAY0G/EI9tvo8nIJEPlkBKwZgt6YW6jn+AS8l0Cc
	PyaGSP7AnNgqJq4gsnG1GadniX8oDIhZw6sTamwZgX6XfBARGqWiz764
X-Gm-Gg: ASbGncuE6SSCXsOQsDqGi1ksyUez5XwVZ2FWsTpvjQgm78sMlN07KDODgp5i+FtJMWA
	GB8uI/slmppwYuTeZmGaiGaggn86INH1ONbe1autNgFB0URVJ166eijc0EHefd24ng6RwIpX8Le
	cJYeAYHoo8IVbJQZVB/gq1dAc0XhATbALcM4PLE+tEPF79tFMXmP2QfU3/prKqZ6zbpdEmR5Z5S
	/4Wwq5BHoeqBdSclFOUjXeux1rTpWp/dxneV0A4fnW/3UoAwrFO0/Q1reOQg6nzpmFmHv5xGQ1G
	/zQZS4nwUJmueDEgDIQ/Yxx5tNlIRJ3G5GwReGPa78+0BaeSG2R4V1r+gDGou371h6fRLH4vc5K
	pAm9WH+zhL008Z65H/Y1tYF1V/2mqYQCxisRA6xilq0GpmMvlDa/9UkaibdGiJ93qPTybc4Wh3m
	A0+wFpJQq0azNEl/NVuLJMeBCqDkmBcCmjmzPqmgwQAaUmuR1s68+L/dtOc9WfiowUBFef6v5h9
	A0dtg==
X-Google-Smtp-Source: AGHT+IHnJ3o0lU2xLaeiHwgSeukdwtR1KGCz5g9vsnkLKv/heK41BVWAROvmPtIvPoJ/A4s01hmsSQ==
X-Received: by 2002:a17:907:1b1d:b0:b3c:3c8e:189d with SMTP id a640c23a62f3a-b7367b8dd38mr1112936266b.32.1763315408563;
        Sun, 16 Nov 2025 09:50:08 -0800 (PST)
Received: from jernej-laptop.localnet (178-79-73-218.dynamic.telemach.net. [178.79.73.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fed9e9fsm879409766b.69.2025.11.16.09.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 09:50:08 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>,
 Maxime Ripard <mripard@kernel.org>, kernel@pengutronix.de,
 linux-can@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Thomas =?UTF-8?B?TcO8aGxiYWNoZXI=?= <tmuehlbacher@posteo.net>
Subject:
 Re: [PATCH can] can: sun4i_can: sun4i_can_interrupt(): fix max irq loop
 handling
Date: Sun, 16 Nov 2025 18:46:51 +0100
Message-ID: <5938604.DvuYhMxLoT@jernej-laptop>
In-Reply-To:
 <20251116-mysterious-delightful-spaniel-18d220-mkl@pengutronix.de>
References:
 <20251116-sun4i-fix-loop-v1-1-3d76d3f81950@pengutronix.de>
 <2804881.mvXUDI8C0e@jernej-laptop>
 <20251116-mysterious-delightful-spaniel-18d220-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Hi!

Dne nedelja, 16. november 2025 ob 17:26:07 Srednjeevropski standardni =C4=
=8Das je Marc Kleine-Budde napisal(a):
> On 16.11.2025 17:20:37, Jernej =C5=A0krabec wrote:
> > Dne nedelja, 16. november 2025 ob 16:55:26 Srednjeevropski standardni =
=C4=8Das je Marc Kleine-Budde napisal(a):
> > > Reading the interrupt register `SUN4I_REG_INT_ADDR` causes all of its=
 bits
> > > to be reset. If we ever reach the condition of handling more than
> > > `SUN4I_CAN_MAX_IRQ` IRQs, we will have read the register and reset al=
l its
> > > bits but without actually handling the interrupt inside of the loop b=
ody.
> > >
> > > This may, among other issues, cause us to never `netif_wake_queue()` =
again
> > > after a transmission interrupt.
> > >
> > > Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support -=
 Kernel module")
> > > Cc: stable@vger.kernel.org
> > > Co-developed-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> > > Signed-off-by: Thomas M=C3=BChlbacher <tmuehlbacher@posteo.net>
> > > Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> > > ---
> > > I've ported the fix from the sja1000 driver to the sun4i_can, which b=
ased
> > > on the sja1000 driver.
> >
> > Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
> Thank you very much! I have seen a lot of feedback from you about the
> sun4i driver. Would you like to become the maintainer of the driver?

As a Allwinner (sunxi) maintainer, it is somehow implied that I help with
reviewing such drivers, right?

However, while I never used sun4i_can driver, I know CAN protocol well
as I work with SJA1000 compatible controllers at work, so I can help with
maintaining it.

Best regards,
Jernej



