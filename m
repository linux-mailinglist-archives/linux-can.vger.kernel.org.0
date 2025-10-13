Return-Path: <linux-can+bounces-5165-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D851FBD2CD1
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 13:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5503BCE51
	for <lists+linux-can@lfdr.de>; Mon, 13 Oct 2025 11:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F5425A2C8;
	Mon, 13 Oct 2025 11:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGfBZ6s8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3916D13D891
	for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 11:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760355370; cv=none; b=CW2j1pm533UT/ZmY1Pu6PbK8x1fwMExZmhJW6i3bjw0Pxvls28B8LVOEXePHUaBNCxraorGN9qIvcq5a4e6USW2/dVG3CbESKIpmFsk4Zm4gx8a7kiRSzcevxNmDO2NuwH5on89lntPc/Etl9epLdBK6WDzWQ+IDVpLb+2eZDsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760355370; c=relaxed/simple;
	bh=Uoa6fwRxFOp5yXcDSCcsfCQDeelrFY9em5JImD7PkCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COwoE6He+vhuCAVq75+TplGjCbT7etx5xer1H7rm+ymMYtTB/lzeU6ucEmWby/y3e3Z5HVstMtsfSK1d9jzLeOVfvkeAEOMoVJyCkqU2dC6j194tvtDhPv/A74jmhcn6nPO51ZBu96elIR6lGSgV1nNjNeEaJpMTpe2QrwM3fEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGfBZ6s8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421b93ee372so2204312f8f.2
        for <linux-can@vger.kernel.org>; Mon, 13 Oct 2025 04:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760355367; x=1760960167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Iwo/yWdnbRioc3LFvtoHLGlkOOJnVDJyMIr5OhIkIk0=;
        b=iGfBZ6s8zrM8gDiHiEgul/3cjUP7cIp0oChsm4qnQW/NTNd9F4Wi4IlzkOmjqFWor8
         jL8tlTm30NEpbQHBi8vR+IQgITlgQQGhFubUfiBbxMSZNDzmD87rirQEGXNguQkkjrYY
         Cb6a7JcnCj2Y0udKy9GUGiQiAELA3c8tDHYwuVQI/oho6Pqp8qusA1xsGAsVJjDy+xAJ
         D8x2BbQlrNHx1/5L6fhWgXJCgU8r8GJFJNEcWMrfKN5iQxz8pY8tSlgIUpcZPJ6qzf0F
         EHrtpdQon6yatczImw6m1M9onCBjkfXhwUhIV/roUWcBJDLvcvpoRUnyEM4LW4g2iuaK
         WA+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760355367; x=1760960167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iwo/yWdnbRioc3LFvtoHLGlkOOJnVDJyMIr5OhIkIk0=;
        b=Wj2E5q+yWa/NgaGtrEzbjuDat+q/pJ6pGpk0kzKYJAMH0eC4Y3b+57+KWVQaJaT78O
         A4KZbaFki6FkI6EQpsTjPHUUc/6XK5cU6OdN0Q9f9/s9jSuSWNckympSVazPlHasUNmt
         slO8Dd5F1cwuTFesrV25nZnE5HMGf+SU5Fde3GpNsb//5/HbMj/pRtgYyZjbLCKa/X0s
         ldIIel6r6RzuB7rUncdIUGLfXPupLBv1jv5W8W1uT/z65mnNucDRHYRtkahyP3+9rIOR
         o1mDVgR7jK0C6SD/+za58yV3oVHVkgtdgnb7YZT9SFMlOoMCz7bZRvFbABwhT9lkz27k
         SQxA==
X-Forwarded-Encrypted: i=1; AJvYcCV39uQqiEr89nst1C3Zy6t47Nb8wmEQs7V+PQ/mwaPk3jBTtpwze9k0q1u0Kmg2n22Is+ClUPd3pTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWoooZCYuyBq37lP5TD9Wl+PB+RGStAVNnYeyXL5elfQTf1z4J
	yAVm09JsWjkhyw47+pWPv0uSwKiSI0lWfD36e+HYng8AjO53GgLU8TWf
X-Gm-Gg: ASbGncuaAGixU+mAbSQ01VimY1Aj9NJ23HGDdUnMb+lMdvmcHPHCCSF4y4goHUdhLHf
	OQOuqKpxiPEUyPyr96+atU1neODjb8Mk+U5l8jwfFE6qK/rKWhPoreWoJ3ukkCWcqdpsWYLV0zk
	9HY2kRdo7XQmMWCbMBePxK/FdrS7MimGj3SW5GlBhQV2w8DnX6LtQoCuoFBpAG/NmKTDtVQq27b
	gEOjF5PeJHE5shZqrwzuWNZWR1NEQn6dnVGo5mDoH+YPTi4lFr8AtOxFveqW7TgYYAy2P3Uy28u
	Nv434zQ7gVb4qVlaSLHq10tPItfsbqsh4vyxRyRFExdXhyiudq6W56R/+sVfGoFr6TGsbGVNxw/
	zgAaTVYypBDCSbToH3JsyVKMKvShIWQSXRhs4YsEPWWoywV62yg==
X-Google-Smtp-Source: AGHT+IF6Zt79HEXygH9EvfjQww7YVx29OAymvSr0uzjmK79t/sPfIN0gA2m0SBb6YfkT2CsUA/urvw==
X-Received: by 2002:a05:6000:4901:b0:426:d5bf:aa7 with SMTP id ffacd0b85a97d-426d5bf0c0bmr6137423f8f.63.1760355367228;
        Mon, 13 Oct 2025 04:36:07 -0700 (PDT)
Received: from legfed1 ([2a00:79c0:6da:da00:22ea:3d6a:5919:85f8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce57d4bbsm18111993f8f.2.2025.10.13.04.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 04:36:06 -0700 (PDT)
Date: Mon, 13 Oct 2025 13:36:05 +0200
From: Dimitri Fedrau <dima.fedrau@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dimitri.fedrau@liebherr.com>,
	linux-can@vger.kernel.org
Subject: Re: [PATCH v3 2/2] phy: add basic support for NXPs TJA1145 CAN
 transceiver
Message-ID: <20251013113605.GA177845@legfed1>
References: <20251013-tja1145-support-v3-0-4a9d245fe067@liebherr.com>
 <20251013-tja1145-support-v3-2-4a9d245fe067@liebherr.com>
 <20251013-unyielding-turquoise-mamba-76a0ea-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-unyielding-turquoise-mamba-76a0ea-mkl@pengutronix.de>

Am Mon, Oct 13, 2025 at 11:51:51AM +0200 schrieb Marc Kleine-Budde:
> On 13.10.2025 11:19:19, Dimitri Fedrau via B4 Relay wrote:
> > Add basic driver support for NXPs TJA1145 CAN transceiver which brings the
> > PHY up/down by switching to normal/standby mode using SPI commands.
> 
> The PHY supports standby and sleep mode. Does the PHY framework provide
> a way to configure this?
> 

Didn't find anything related.

> Why do you put the transceiver into standby not in sleep mode?
> 
Datasheet states:

Standby mode is the first-level power-saving mode of the TJA1145A,
featuring low current consumption. The transceiver is unable to transmit
or receive data in Standby mode, but the INH pin remains active so voltage
regulators controlled by this pin will be active.

Sleep mode is the second-level power saving mode of the TJA1145A. In Sleep
mode, the transceiver behaves as in Standby Mode with the exception that
pin INH is set to a high-ohmic state. Voltage regulators controlled by this
pin will be switched off, and the current into pin BAT will be reduced to a
minimum.

I'm assuming that the sleep state would fit into some suspend,
power-off, ... scenario, because the INH pin maybe used to control
regulators.

Best regards,
Dimitri Fedrau

