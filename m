Return-Path: <linux-can+bounces-1558-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2474D984BE9
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 22:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6415284BBF
	for <lists+linux-can@lfdr.de>; Tue, 24 Sep 2024 20:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE26312D75C;
	Tue, 24 Sep 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I40NqvGc"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718CF335C7;
	Tue, 24 Sep 2024 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208189; cv=none; b=BhJ7J+WtJuIg/iFPhi816mdFZtRIsTUDD7s9G60RQ+uXmUUn4/0/gtGQ6y8Zg/lIf+p5A7Wx9H6Z+h+aJf3dSlyVJHx2AlSc6eh2WfDK8yywSZj2aOQ8TJZf0/9M7iQ97emVPMicRg73E7nN1fVXCEopgLWQJDT5z9QQXhjL54o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208189; c=relaxed/simple;
	bh=R0j0vt/5KEvJ6KPsF46C/J5isU7kapggx/Y2JT+dCQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhBT+YQ5O560PRBBrc6eg9TD4cochz4mmW63JutJF90hTGfbEU2oXBhQdv4N5CrVg9jUu/Gw9Zpc2J3ukDxomRvqOgduA6vTR1itQSL74YbX3QGy3t/nJnFkg1ssGn6xiDbmld3FpefQED+M1ZbvoyUgGfeZ5ji8ZJQZx58HdX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I40NqvGc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E249DC4CEC5;
	Tue, 24 Sep 2024 20:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727208189;
	bh=R0j0vt/5KEvJ6KPsF46C/J5isU7kapggx/Y2JT+dCQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I40NqvGcHj+Ogr7wl2beQyU8lmJAtLl3TjQB1Pbxxmh8vWAMEGGMUtMyCLUV6Sajs
	 ppX118DSIaKekLOuo7XKToArUJ9yetUjkOa2TlPz1v8Ga/7ptuH5b8NpvICWdMpV9f
	 iB12NGrdzaeEVyoSH7if/RZs2qG+4wB/wsd19eDk9UcArtHQLEMQTxWkACSUuOsIOk
	 pUcgXt8hyJh7girLA0b/Lz/V9bUMQ/zm5GFXJT1ZktcelkSoAy0NZsLKQRhXTiJCni
	 McsvguBvOcwkZ63wf5P0bat4YeOq+L4quZX9GbrNCJ0wyvtcLJXFoiMiLyNQNTKNUa
	 5PK/eJCBeL9iQ==
Date: Tue, 24 Sep 2024 15:03:08 -0500
From: Rob Herring <robh@kernel.org>
To: Hal Feng <hal.feng@starfivetech.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	William Qiu <william.qiu@starfivetech.com>,
	devicetree@vger.kernel.org, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: can: Add CAST CAN Bus Controller
Message-ID: <20240924200308.GA24484-robh@kernel.org>
References: <20240922145151.130999-1-hal.feng@starfivetech.com>
 <20240922145151.130999-3-hal.feng@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240922145151.130999-3-hal.feng@starfivetech.com>

On Sun, Sep 22, 2024 at 10:51:48PM +0800, Hal Feng wrote:
> From: William Qiu <william.qiu@starfivetech.com>
> 
> Add bindings for CAST CAN Bus Controller.
> 
> Signed-off-by: William Qiu <william.qiu@starfivetech.com>
> Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
> ---
>  .../bindings/net/can/cast,can-ctrl.yaml       | 106 ++++++++++++++++++
>  1 file changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml b/Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
> new file mode 100644
> index 000000000000..2870cff80164
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/can/cast,can-ctrl.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/can/cast,can-ctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CAST CAN Bus Controller
> +
> +description:
> +  This CAN Bus Controller, also called CAN-CTRL, implements a highly
> +  featured and reliable CAN bus controller that performs serial
> +  communication according to the CAN protocol.
> +
> +  The CAN-CTRL comes in three variants, they are CC, FD, and XL.
> +  The CC variant supports only Classical CAN, the FD variant adds support
> +  for CAN FD, and the XL variant supports the Classical CAN, CAN FD, and
> +  CAN XL standards.
> +
> +maintainers:
> +  - William Qiu <william.qiu@starfivetech.com>
> +  - Hal Feng <hal.feng@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +        - starfive,jh7110-can
> +      - const: cast,can-ctrl-fd-7x10N00S00

What's the 7x10...? Perhaps some explanation on it.

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: apb
> +      - const: timer
> +      - const: core
> +
> +  resets:
> +    minItems: 3
> +
> +  reset-names:
> +    items:
> +      - const: apb
> +      - const: timer
> +      - const: core
> +
> +  starfive,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller syscon node
> +          - description: offset of SYS_SYSCONSAIF__SYSCFG register for CAN controller
> +          - description: shift of SYS_SYSCONSAIF__SYSCFG register for CAN controller
> +          - description: mask of SYS_SYSCONSAIF__SYSCFG register for CAN controller
> +    description:
> +      Should be four parameters, the phandle to System Register Controller
> +      syscon node and the offset/shift/mask of SYS_SYSCONSAIF__SYSCFG register
> +      for CAN controller.

This just repeats what the schema says. More useful would be what you 
need to access/control in this register.

Rob


