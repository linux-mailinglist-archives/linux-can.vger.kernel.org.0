Return-Path: <linux-can+bounces-1684-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED5899DF9A
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 09:47:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B62283E0A
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 07:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486101AAE2C;
	Tue, 15 Oct 2024 07:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="calJfOMX"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94ADF9474
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728978450; cv=none; b=VqUXvy2Qwthh3mfl4nSE96lrpfNICgxC7DEMYN2A64gcdUkyY5it5h89jnG2d5zIPDl1Bhk52ZP3vNpYV8dciqGU71OLOQ8sIBA0GUmbSt07k91eSBuzhT6fkKyVXN/QNw0awnlw3PdGSOKi1jP1WVEfhT0pQob4CYtdn90UelM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728978450; c=relaxed/simple;
	bh=GoYun2YYoTvYmiRDG/kn1RcNsjKDNfpXI7EBbEdeECY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m1arsu44nDoVzg7FziCV4q1GikYj+1Uh1JsY/0g4u062SB8F/Woak2bx3O6MXneGB4DbgXu4GXuNUDAd5uoCJO8x42IgywTKC8HNbLXqecXoQ4y5IhmHvDLxTnJg5uwlI2hq5embPcbWCEy3O5l9hmcy5s7r8g6I5WXepaaauJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com; spf=pass smtp.mailfrom=amarulasolutions.com; dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b=calJfOMX; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amarulasolutions.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e290333a62cso4318478276.2
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 00:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1728978446; x=1729583246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ny3mMnaV1bWHFaghg1EFFxrb9SGa0BxTVXFYRJ+SBQk=;
        b=calJfOMXY/NNvUJpEgJgC4SwCsVX8+YtjSEZF2kigMpO1tRQrVp2Kt+KHOMbN6jLiK
         7t8zbo9KheD25j/UddkVXl7GmWyTNwIYggXhJHZ4Q5HLwB94SwLPFCw2Zet/CWxJH0wE
         b6se9wLXlje/O2v6BfmAaI5O5cF3ulqqJDBbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728978446; x=1729583246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ny3mMnaV1bWHFaghg1EFFxrb9SGa0BxTVXFYRJ+SBQk=;
        b=SIRToITu2k8tMc1f1MPKmr1TjZdNuTIlSmkFjjBEmNZ5+HrZuCjDq9t6CCodNpTdw5
         ln9x7kA8ZkTttIb2WoXYsg5UZSNCxj/KSH1Nm8+VdMYL15k/DzGn0P6kYusmVnEsIAv3
         RWL4MLrxnnq7LUb3A6Z/w1K/Z+eYoJuQA9nmSdcVGCBWpOzhHI/Zy63yE/G9e5bgDrRd
         yXT2RgKIUJCk3J3JeczWOHYyp4rbwcHfId2kcC/UJxkcIHCiKRs9tG45K8ZrhAa8LSpP
         gJGYjnscWKACCvXH3+eZnze7FOX8E6CSTI+ennWzTanjnPzl/oQIwt0ul9yEyEmPmx9X
         amRg==
X-Forwarded-Encrypted: i=1; AJvYcCVgtF6XRz6HnEOgCQNrJopcCrAPhHNhi2c9TpWH6NTqylovGSRu8WoD/UtU4w+Kht5VhZdPFxfbLak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9U9BLhacWAsd+1DpjnCwn+Ds5CtvNFwfe+05DZxux7zrX87YS
	KJ9da482WnE+j+uCoX/ndHslXuLRFFa6CfKUU5zBCdXZIoqKfteHE8ogp3+BA0X1DxEhHIbmvIO
	mGLks5jr+LqkYBq6TGz0RO4BsjKlDYCxGS45eSg==
X-Google-Smtp-Source: AGHT+IFgcEDMyom21Dz2iBKuv7QRbE23W0I2PN9yM0SwHrPflX6W8Qg+QqYjwWyekpXsOIPP654YogteFiOVKx2vr08=
X-Received: by 2002:a25:d013:0:b0:e28:fee0:e971 with SMTP id
 3f1490d57ef6-e2919d8417dmr8779781276.22.1728978446526; Tue, 15 Oct 2024
 00:47:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241014152431.2045377-1-dario.binacchi@amarulasolutions.com>
 <20241014152431.2045377-4-dario.binacchi@amarulasolutions.com> <20241014-active-versatile-armadillo-717c4f-mkl@pengutronix.de>
In-Reply-To: <20241014-active-versatile-armadillo-717c4f-mkl@pengutronix.de>
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Date: Tue, 15 Oct 2024 09:47:15 +0200
Message-ID: <CABGWkvohy1vQ4nbUpWcJ0jJTX6EPHhQSBmdmiGxT=uhf7hf3CA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] can: dev: add helper macros to setup an error frame
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-amarula@amarulasolutions.com, 
	michael@amarulasolutions.com, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-can@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Marc,

On Mon, Oct 14, 2024 at 10:00=E2=80=AFPM Marc Kleine-Budde <mkl@pengutronix=
.de> wrote:
>
> On 14.10.2024 17:24:18, Dario Binacchi wrote:
> > These helpers can prevent errors and code duplication when setting up a
> > CAN error frame.
>
> I personally don't like the ideas of using macros here. Is there a
> reason not to use static inline functions?

I thought that the use of macros would certainly not introduce
additional overhead
compared to the previous version. In version 2, I will replace the
macros with inline
functions.

I noticed that the ACK error is handled differently by the drivers.

bxcan, flexcan, slcan, rcar_can.c, and xilinx_can, for example:
cf->can_id |=3D CAN_ERR_ACK;
cf->data[3] =3D CAN_ERR_PROT_LOC_ACK;

at91_can, mcp251xfd-core:
cf->can_id |=3D CAN_ERR_ACK;
cf->data[2] |=3D CAN_ERR_PROT_TX;

cc770, kvaser_pciefd and es58x_core only
cf->can_id |=3D CAN_ERR_ACK;

So, what is the correct/best way to notify a CAN frame error from an ACK?

Thanks and regards,
Dario

>
> Marc
>
> --
> Pengutronix e.K.                 | Marc Kleine-Budde          |
> Embedded Linux                   | https://www.pengutronix.de |
> Vertretung N=C3=BCrnberg              | Phone: +49-5121-206917-129 |
> Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-9   |



--=20

Dario Binacchi

Senior Embedded Linux Developer

dario.binacchi@amarulasolutions.com

__________________________________


Amarula Solutions SRL

Via Le Canevare 30, 31100 Treviso, Veneto, IT

T. +39 042 243 5310
info@amarulasolutions.com

www.amarulasolutions.com

