Return-Path: <linux-can+bounces-1412-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B6D96CACA
	for <lists+linux-can@lfdr.de>; Thu,  5 Sep 2024 01:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91611C24A31
	for <lists+linux-can@lfdr.de>; Wed,  4 Sep 2024 23:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC71179654;
	Wed,  4 Sep 2024 23:27:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCA1172760;
	Wed,  4 Sep 2024 23:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725492466; cv=none; b=TjQLYFSu4D3ocWs5r1CjVvg2F72U5WXegLsaeV/i+CJyJSZgnrSEUEDJcPiWH2OvZs78elkCUBaRjfo0zV2W0BAHd9ZDu++po50sd0MPjWko05CLcEQjXAFKnzhVhVrwk/H8sjW3LF10ElVQi0WL+u/WPtDRG/pmiOEX1+DA5n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725492466; c=relaxed/simple;
	bh=xnqrdElsRqVveTFKGGQ2DYoVeTa9JnaT0qEfim4KzbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cD59C7pv/F40GO70TSxBl+Ov7lih9O4lgPoNNotwGFbUG5m61IPfkA2J6vjo81nC58juOsJE8wJGQIebDMj29OjyNLjijdD3m8WCsVJWTa2TA3+jMKEm6QcQ0c/2lQG6CsTaBapqJVCun3/5m+Nw7MITBHSzCYnDXOBTyvDIuTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7c3ebba7fbbso174426a12.1;
        Wed, 04 Sep 2024 16:27:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725492464; x=1726097264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnqrdElsRqVveTFKGGQ2DYoVeTa9JnaT0qEfim4KzbI=;
        b=MHLUh6pWz1itQuwjqpEjtt+NxjYPCtvmddRMO6GJ7kc43KykAOytLbpl6OIlCtmbxE
         JAgYmUyXIFNAij5if+q38EXKpzvzFibQfY3h1Tr00WVXeI9OXNru5AtJ7EmhpKPX9Z9i
         K0U7BebZJVsoUVGEsgDbuGmrFn9h2HcUvR/REUzK/1Atu7MKHSSFt3IDp2k7ZVKRoXma
         +7/W5my6RWeGXb2TklDPCPUHHfbvjdkFoYyiHw5PvkCD0DcMViZPofPZz+dszHJi1Vd3
         44At8W4UQrV4Wpe2/diDEvLs81fZ521xLQFInpunjWAUF1N4e1yNEKk+BRC5foyw6yZM
         uTQg==
X-Forwarded-Encrypted: i=1; AJvYcCUth3PUqtbmqD7WzPkvkIFPElRA7amYgjlAPDnfScezja+ntGtLeBQu34XYfH931qPCpDE4LyN+F3U=@vger.kernel.org, AJvYcCV37fWZLG3Hmp549kOL0YBD+fOIGxHcfM2EvVxAU7y7HBDcHK11ZE0+DSnLhvkvDfxs4z/tXasJ@vger.kernel.org, AJvYcCXFd0HgQCC2BpWD40joomKl1gqLin1K+LjT8f5nWqS2knQJ148MIsSJwbMZtIOYilUZRZJtTtI+@vger.kernel.org
X-Gm-Message-State: AOJu0YwnmdcpgijCI6iR3JBWytI/M6sZdqXvk57IzlcTJ8RRUEtEDSih
	7RUh//VBGtnztEBPx7e4rOSDtdQ0kdLWVlC0rA65uab2I8rfC4VcsYxaTvv9l/GjvXwx4slStTe
	2V8Yh6BU5VRM1pSbOOW0kWP0XYTA=
X-Google-Smtp-Source: AGHT+IHsuLP5v+T/Exu24ZloORU9KnSyFncxYZCSSj31Y/Uyl9Y2UmkVWrMbsVuwOSOQE7OlwIZP1vFaemJpw/RJfx4=
X-Received: by 2002:a17:902:ccc2:b0:202:508c:b598 with SMTP id
 d9443c01a7336-20546b55432mr209414275ad.59.1725492464436; Wed, 04 Sep 2024
 16:27:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904222740.2985864-1-stefan.maetje@esd.eu> <20240904222740.2985864-2-stefan.maetje@esd.eu>
In-Reply-To: <20240904222740.2985864-2-stefan.maetje@esd.eu>
From: Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Date: Thu, 5 Sep 2024 08:27:33 +0900
Message-ID: <CAMZ6Rq+Ns3ta2TS+y8fVBqBKxtYpRciRAtuPXUmFFHzM1qj2pg@mail.gmail.com>
Subject: Re: [PATCH 1/1] can: esd_usb: Remove CAN_CTRLMODE_3_SAMPLES for CAN-USB/3-FD
To: =?UTF-8?Q?Stefan_M=C3=A4tje?= <stefan.maetje@esd.eu>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, Frank Jungclaus <frank.jungclaus@esd.eu>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefan,

Thanks for the patch.

On Thu. 5 Sep. 2024 at 07:29, Stefan M=C3=A4tje <stefan.maetje@esd.eu> wrot=
e:
> Remove the CAN_CTRLMODE_3_SAMPLES announcement for CAN-USB/3-FD devices
> because these devices don't support it.
>
> The hardware has a Microchip SAM E70 microcontroller that uses a Bosch
> MCAN IP core as CAN FD controller. But this MCAN core doesn't support
> triple sampling.
>
> Fixes: 80662d943075 ("can: esd_usb: Add support for esd CAN-USB/3")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stefan M=C3=A4tje <stefan.maetje@esd.eu>

Reviewed-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

