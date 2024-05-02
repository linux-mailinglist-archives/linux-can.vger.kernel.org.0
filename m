Return-Path: <linux-can+bounces-532-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2C8B97C1
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 11:31:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 285D01F2794C
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7315854750;
	Thu,  2 May 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ/rCVqO"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DECC535BF;
	Thu,  2 May 2024 09:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714642273; cv=none; b=e4Rxsj+Fk13SILg/i7ovr/5p/idcxI7WPvmqXOQkpvbHvGC4kRaflfGwy3N/Jl61ZcDZqKbKe7NYsd5qT9eVLVRkYo11/nuYZxqQpbWv5lsX5mkI4ZGCPULmBmhFSpgl1+FLMV22nFVB4ZMYH47tixSArKB8PJeUE24zVSS40Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714642273; c=relaxed/simple;
	bh=nxJJn2KewqMIkJ3dMF9ZpNtiUYcYj+4rxjpVDnMCCH4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=Ewp+thh4GWusv7hevUrvELQLHBLuSqURrKEKsKf4C7H4FdRJJIrK9FPu8TeHY5Uj3lzi+Wq/SUQkiWOA0OFF6Lbc+ZO7Pey4fI4hdm4ybmXYS5qXzf50RFLOK6YMmNNFd1cNJpP3ZmBgs2/YdriqWnBat+uPQ85hH6W8lvE63ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ/rCVqO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD2AC113CC;
	Thu,  2 May 2024 09:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714642272;
	bh=nxJJn2KewqMIkJ3dMF9ZpNtiUYcYj+4rxjpVDnMCCH4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=PQ/rCVqONlYul6a7Vey4ZpsZNR/8RHzWfdCsO0OjVsN++uyuidq/GnK7jFsjk8jRt
	 6GYrk20mqMEzqCeniofiDenRPQsr43EJTz7LpOAXqonFCzL9/nzdyJBy9DBA//tjt+
	 7hu4b2CMF8bmkqi3naK0gZSAKurPzKecyIuo95xxZE3z3M4cENY6f05TgTgvFhr//w
	 VEm+BzvNqOAPMaxafKctqMturibXSvjuLbR8Bb7Pn/CAhJw6vc+5ZKi3al9GhAwZKs
	 dKM/uarhG9uUE6yY5fLINmUezz7y8T+Dm8M9+YRDImItM9bLcw2Txf3MQPpTT+p1Nn
	 p+4roxajhRGdQ==
Date: Thu, 02 May 2024 04:31:11 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sebastian Reichel <sre@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-serial@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, 
 Jiri Kosina <jikos@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Andreas Lauser <andreas.lauser@mercedes-benz.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Benjamin Tissoires <bentiss@kernel.org>, devicetree@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Paolo Abeni <pabeni@redhat.com>, linux-can@vger.kernel.org, 
 netdev@vger.kernel.org, linux-input@vger.kernel.org, 
 Pavel Pisa <pisa@cmp.felk.cvut.cz>, 
 Oliver Hartkopp <socketcan@hartkopp.net>, 
 "David S . Miller" <davem@davemloft.net>
In-Reply-To: <20240502075534.882628-7-christoph.fritz@hexdev.de>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
 <20240502075534.882628-7-christoph.fritz@hexdev.de>
Message-Id: <171464227142.1356329.4931419696225319861.robh@kernel.org>
Subject: Re: [PATCH v2 06/12] dt-bindings: net/can: Add serial (serdev) LIN
 adapter


On Thu, 02 May 2024 09:55:28 +0200, Christoph Fritz wrote:
> This patch adds dt-bindings for serial LIN bus adapters. These adapters are
> basically just LIN transceivers that get hard-wired with serial devices.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.example.dtb: /example-0/serial/linbus: failed to match any schema with compatible: ['linux,lin-serdev']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240502075534.882628-7-christoph.fritz@hexdev.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


