Return-Path: <linux-can+bounces-2121-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17249D358B
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 09:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D556B2326E
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 08:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F1F1714B5;
	Wed, 20 Nov 2024 08:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="aZmonetf"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-26.smtpout.orange.fr [80.12.242.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C363C8615A;
	Wed, 20 Nov 2024 08:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732091660; cv=none; b=bu4KvoiCFW9OIXxV5AJdKb20a7rzlgkJ/F+bjInJ3kG4rjqeXgZKxghrUkvlsgyJaL7iszVnemKqhjZCM/VrDqpGKFPCVRwSZB69Hv3rb0flqXmOOFT0yAqm0K/neXlXh8jO0izM5XEdJmjFgtl+Dydl+Y+HByfiG7qRFugatKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732091660; c=relaxed/simple;
	bh=tAP3yA2f13hGp4ZFJlv2MEDIvrRVb0ghzYb5MaYX2Iw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSBSDLb1XUa0mxwU08JT1Vz9RiA/a9FB3XMQhpj1Zrtwzg/WyGJXjl7aAYz9lACPcmJCxNqHDkf9u1VaEfqAbcigwod2JJMxtNE9HlsmO2QsuPHVhI1qNnEhwy4vwO1LLlSiAVUUbA2bZm4va3ZAH/n22yLGfz4d2LzuVis4fHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=aZmonetf; arc=none smtp.client-ip=80.12.242.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by smtp.orange.fr with ESMTPSA
	id DgA5t0hcpdDuoDgA5tTTc9; Wed, 20 Nov 2024 09:34:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1732091649;
	bh=adOYQK7aPwsLhM4oKvhYzDNey9j7CMddEcH9FCvvTQo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=aZmonetfTwrSQRz9cLp37mKUGxkVgBWLtyJqBYehhxdnoLWUTcAUwdSTZDc/Yadm7
	 HJ3KloKd5t0MJoy4eW/qBqyVbhgfauA/pjbk2/vjDRDoyL3iLdWR9MvxToRmUwv9wq
	 q45uKP4z5RyVYOsgN8UgDtDTKlWhblVfDOvkCIEbAa64sC5qGMR6/hU/nyz5eMkGJl
	 qRlaKwTSbPUd5cGrdQAmVQ4gd9Jfo5//r27Y+pzlh0CwcqPQf6QsbYD1Vu0KfSaqfV
	 WIikLTZTOoCSZEr5JeoKEcvi3GAPbWOkvA00l8uA1oPWPx8cD0qWO29P+p9TWJtp4Q
	 cDn8N2niGJMKQ==
X-ME-Helo: mail-ej1-f46.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Wed, 20 Nov 2024 09:34:09 +0100
X-ME-IP: 209.85.218.46
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9ec267b879so872510366b.2;
        Wed, 20 Nov 2024 00:34:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUNmdM0VypPdB3ERU6IPif/scqfpuuU2MtQKAADEBWI4OiQEyg4pKjiBtgpuPt1EfzKNBkiSljb@vger.kernel.org, AJvYcCUwRF9jxZ6/M5DvGMO6+hv3BESDcy3QqpH99CYnjvWGGXtNanX4W3N0y5d9l1vU4/F85ZjcFgQQIDYo@vger.kernel.org, AJvYcCV32uZt4sX119DMdqsJcw+x4EGOO+Mw99gFzW8fa8Eqya73zGlP1v2PTDya7Bwdcodp8/K7tisYuk7D@vger.kernel.org, AJvYcCXwJda8Azq3+se4+fJyBpoYjLvq+9fy6K4jihUQIofPMrXEG+jfsoxpIWGSyRKAPhintPPDNErPbGCljBmW@vger.kernel.org
X-Gm-Message-State: AOJu0YyZFvW1hy8BVlG0Qyor5CEBncmqBoFpj32TGO6jRDgJPFMlv/Ub
	vhEu5FkiRak9u8FtxoJiL78gAG4754GgNHhuBaGYcmb5L8SSifLj3Le5XHXcGfESXDcv/njd9FA
	X5t793ts3/pXwdj9F1NquoExkc+Y=
X-Google-Smtp-Source: AGHT+IHq//r1Bhfb10lz2TdZss0bHvnz2xrRldR2txbJnOPf5VJ4xHiRgJrfjwg3eL3UDdKFiypf3HZSDLQGAzTZ8vQ=
X-Received: by 2002:a17:907:96a1:b0:a9a:3d5b:dc1a with SMTP id
 a640c23a62f3a-aa4dd55043cmr167204066b.15.1732091649036; Wed, 20 Nov 2024
 00:34:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
In-Reply-To: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Wed, 20 Nov 2024 17:33:58 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKikFgtpYQ-SwV55hCzHHJ=7bbpmcfSPedheUwmFDDqJA@mail.gmail.com>
Message-ID: <CAMZ6RqKikFgtpYQ-SwV55hCzHHJ=7bbpmcfSPedheUwmFDDqJA@mail.gmail.com>
Subject: Re: [PATCH] docs: remove duplicate word
To: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Thomas Kopp <thomas.kopp@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed. 20 Nov. 2024 at 13:40, Ruffalo Lavoisier
<ruffalolavoisier@gmail.com> wrote:
>
> - Remove duplicate word, 'to'.
  ^^

No need for the "-", this is not a list. I am fine if this is fixed by
Marc while applying.

Under the condition that the Sign-off-by: tag issue gets resolved:

Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

