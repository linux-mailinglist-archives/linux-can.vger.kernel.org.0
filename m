Return-Path: <linux-can+bounces-469-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93ADE8AC6F2
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 10:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 325791F2063D
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 08:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B615029C;
	Mon, 22 Apr 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/liFmLi"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A467651C46;
	Mon, 22 Apr 2024 08:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774409; cv=none; b=U8GtCXvcLhrPakMdQQEWsTJafHwRHqBuqrFbHiuyfXydXOIjifpvGeAU26O++C9WXuBxiJRIC05BGrOeVVLIvTNORfbzknvdk9+nXnEcJK3hhqkIsGhdBUmfi1isD5rHtkjw/I1L6dwPqKAfizXzL+M3/rImrGH1n/VhsPKPBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774409; c=relaxed/simple;
	bh=DqdqDFnZ+YUvebT1NAXo2ShsLjrf3XUSBWmbdnKI6HU=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=kvl56KNdxwD+v9WhNHQAgRhjw4rbDXHcqmB7FgpMlMlFu9yT2TOwpdiWgS+7uMGXGMTHwsD1GEwIl8Pb1U3+XF03Tp7bcv3t+JWrd6uSOOk8H8x6oaG+MSUxRpNt7c5XmhtUhTKmLFDWw8zt8co8Iw18Thfx2069tsMuo39iMPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/liFmLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0ABC113CC;
	Mon, 22 Apr 2024 08:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713774409;
	bh=DqdqDFnZ+YUvebT1NAXo2ShsLjrf3XUSBWmbdnKI6HU=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=G/liFmLilfjZ4Kj7Wt6Z0/xwSTwm2ArRgNWKX4SxDyvFYPIVG24dXQS/1bvlOsEER
	 qC+o3FLrUReL6eFdAUf0V+kdrSwbou1U9WWrfMRG0Y2j3+/sTS8QtLtDE2Mu84QyFX
	 9wVhclxgKv3im2Vr9l30p0SE9FKVfyUBrqw/QmcLIuv2QDKq62QvC3UA8483h6+Utv
	 thqfRKH3PP8ZPfLDsty4JSq9h2WyQzG99bOHggcJQRHfRD+5VZlxDE408FNsJAd9tI
	 H9QcePwBKNtZtDONjDhryImErCE4LnREClbrvS6z9EaUXHd5jgYBwlVsa8IszblwB8
	 /3+rPX0kxgpFQ==
Date: Mon, 22 Apr 2024 03:26:48 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Christoph Fritz <christoph.fritz@hexdev.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 linux-input@vger.kernel.org, linux-serial@vger.kernel.org, 
 Oliver Hartkopp <socketcan@hartkopp.net>, netdev@vger.kernel.org, 
 "David S . Miller" <davem@davemloft.net>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Benjamin Tissoires <bentiss@kernel.org>, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Jakub Kicinski <kuba@kernel.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Jiri Kosina <jikos@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Jonathan Corbet <corbet@lwn.net>, devicetree@vger.kernel.org, 
 Andreas Lauser <andreas.lauser@mercedes-benz.com>
In-Reply-To: <20240422065114.3185505-6-christoph.fritz@hexdev.de>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
 <20240422065114.3185505-6-christoph.fritz@hexdev.de>
Message-Id: <171377440691.455449.12311389300613565393.robh@kernel.org>
Subject: Re: [PATCH 05/11] dt-bindings: net: can: Add serdev LIN bus dt
 bindings


On Mon, 22 Apr 2024 08:51:08 +0200, Christoph Fritz wrote:
> Add documentation of device tree bindings for serdev UART LIN-Bus
> devices equipped with LIN transceivers.
> 
> Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
> ---
>  .../bindings/net/can/linux,lin-serdev.yaml    | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Error: Documentation/devicetree/bindings/net/can/linux,lin-serdev.example.dts:18.9-15 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:427: Documentation/devicetree/bindings/net/can/linux,lin-serdev.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
make: *** [Makefile:240: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240422065114.3185505-6-christoph.fritz@hexdev.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


