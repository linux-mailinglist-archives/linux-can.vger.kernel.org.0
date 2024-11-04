Return-Path: <linux-can+bounces-1864-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FFD9BB0EA
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 11:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F92817E6
	for <lists+linux-can@lfdr.de>; Mon,  4 Nov 2024 10:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA1C1AF4EF;
	Mon,  4 Nov 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rut4Py5v"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A551B0F09;
	Mon,  4 Nov 2024 10:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730715771; cv=none; b=MeUe2TL2L10erg068N68o1MzzLdV8nCaEK6i2AO0ZdSsFJdV81B4XVk6Maf/2mQ8xnTjOruGBw20X2TRKz6jGgPuyb87RgyjJWd8y9F6lTiC1x6fiZgwS/C7W9Wb4AUGuWCkEEd7tmHftwJiz0PfFEylXNvuhcTmLbcWGJbEKvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730715771; c=relaxed/simple;
	bh=nMfTLLFzcG1ZcG1H25Gar8chdwYJf1C0bitXKfycbJ4=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=FjgDZIB1xSLCJcxwpBcuoRYF6z/FGBrNyhIo0VveQieFMakNb5BuAsLZBkqpF6uYhVgyH/jRNzrrhUXO8E9D/t8z9VdccBs2FQ23+kMG/32KU5RsXHCiLouRhftfPLWV0aLwqaRyoDiJdMEOEl2dNBVzO8bAmGxgnjnKc5ML7QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rut4Py5v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC163C4CECE;
	Mon,  4 Nov 2024 10:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730715771;
	bh=nMfTLLFzcG1ZcG1H25Gar8chdwYJf1C0bitXKfycbJ4=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=rut4Py5vVrIi6BT1pfGKTCXZcGyAz3HgoAkBuQSfnktQis/5pd67FT7i3fpSNt9lI
	 RVmQ/2kxQEXTovrZLkvfIa/FXiEjXcpP//w/H7jFsMfmapoMbnCENuiSNhAEGfWS3q
	 8m+AvAmgpE41vBfzwg/cpYykzPHK+afTeqCCR7u3IHp8wsH9WXoRW+1IMKc/TCgFYM
	 WWYErn3sC4kK9WLypVS8iGMb4Yd0uq0SbYOJXODcA/jZPeZnDn89od35lemgHI3s0S
	 oYjrDUruelmeCbTg2CNcmhGXaZy/ojbtD/KTN+dETvSoSy/Pl/i23azPrCfw3k6GK4
	 CO3QFKAgO/ErA==
Date: Mon, 04 Nov 2024 04:22:48 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Sean Nyekjaer <sean@geanix.com>
Cc: Conor Dooley <conor+dt@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-kernel@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241104085616.469862-1-sean@geanix.com>
References: <20241104085616.469862-1-sean@geanix.com>
Message-Id: <173071576894.2866974.11023196178832654081.robh@kernel.org>
Subject: Re: [RFC PATCH] dt-bindings: can: convert tcan4x5x.txt to DT
 schema


On Mon, 04 Nov 2024 09:56:15 +0100, Sean Nyekjaer wrote:
> Convert binding doc tcan4x5x.txt to yaml.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> 
> Can we somehow reference bosch,mram-cfg from the bosch,m_can.yaml?
> I have searched for yaml files that tries the same, but it's usually
> includes a whole node.
> 
> I have also tried:
> $ref: /schema/bosch,m_can.yaml#/properties/bosch,mram-cfg
> 
> Any hints to share a property?
> 
>  .../devicetree/bindings/net/can/tcan4x5x.txt  | 48 ---------
>  .../bindings/net/can/ti,tcan4x5x.yaml         | 97 +++++++++++++++++++
>  2 files changed, 97 insertions(+), 48 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>  create mode 100644 Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.yaml: properties:bosch,mram-cfg: 'anyOf' conditional failed, one must be fixed:
	'description' is a dependency of '$ref'
	'bosch,m_can.yaml#' does not match 'types.yaml#/definitions/'
		hint: A vendor property needs a $ref to types.yaml
	'bosch,m_can.yaml#' does not match '^#/(definitions|\\$defs)/'
		hint: A vendor property can have a $ref to a a $defs schema
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: bosch,mram-cfg: [0, 0, 0, 16, 0, 0, 1, 1] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/ti,tcan4x5x.example.dtb: can@0: bosch,mram-cfg: [0, 0, 0, 16, 0, 0, 1, 1] is not of type 'object'
	from schema $id: http://devicetree.org/schemas/net/can/ti,tcan4x5x.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241104085616.469862-1-sean@geanix.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


