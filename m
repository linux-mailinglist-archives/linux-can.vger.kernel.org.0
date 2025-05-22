Return-Path: <linux-can+bounces-3665-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFB2AC089B
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 11:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73BA51B66F55
	for <lists+linux-can@lfdr.de>; Thu, 22 May 2025 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D7D237164;
	Thu, 22 May 2025 09:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO9mh0dY"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DFB70814;
	Thu, 22 May 2025 09:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747905945; cv=none; b=dH3+NooyCFbcrcy5DET5GrTfL5cKU5HkHWnCnIzJ3Gtheez7vf2+y5J16vF4xRfbOkQIfkSmIzPMvRds4lk9QAIZJXKBcHnTX5DxVrC50EJ5NWUKuR0sYjW/7nQ2GrvJtBzNjEMMv0reGR73hbheGsZfWqGh4HnSS9GLDxf7TI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747905945; c=relaxed/simple;
	bh=p53SfCe7muDgtvQFHMIVqvkowaeuQ3Tx7It7jszYKD4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=W/rJ2baNPFjdqLCTfk2qEh4GsNepGzQQJJB9JOmGgdIpFCrS9UVPALJOnzqA4r16lg67NaAevp1ygJolIa8tDxOTMoAT6mFSXZIT3cigTnuerHFFPnhNOfbmeoIFHCWu1p3ghKAqU50K8N/E32Jz9yMYvykBU4+kcmJ5jI/oAVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO9mh0dY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34187C4CEE4;
	Thu, 22 May 2025 09:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747905942;
	bh=p53SfCe7muDgtvQFHMIVqvkowaeuQ3Tx7It7jszYKD4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=CO9mh0dYYJ6S4syWXHaQCopevlhaqGAYO5iqcLaWHMlY00lVp9y+W4/oG4MnnBP4/
	 tr+s3pHewoNQEBg1NNcnx3voyBJHMTfpOzB+48AgrF4gMYvM/+/dkDnqj9oUDN6D4+
	 Cd1x7EZ8bzOpZvmQVk0+QhRzIyf2h+4mYCnu/ILvzt4ucD1XT6EMrpItDesYc8MZrK
	 3xeM2zdbF2zBeiW6drS2KAe8uMiwbLrK55SzE6/qzNQeC23AFvjE3Vd1i1wV0BdXHA
	 yiO+mEI+J3ejMfzo58Vj+tJb1V7ynQZO1dCjTIzeK1T7CB6Hp/OQcJAxodLqFZjjkn
	 P35doFcmKnAvw==
Date: Thu, 22 May 2025 04:25:40 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, krzk+dt@kernel.org, cl@rock-chips.com, 
 mkl@pengutronix.de, conor+dt@kernel.org, linux-can@vger.kernel.org, 
 mailhol.vincent@wanadoo.fr, kever.yang@rock-chips.com, 
 kernel@pengutronix.de, linux-rockchip@lists.infradead.org, heiko@sntech.de, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Elaine Zhang <zhangqing@rock-chips.com>
In-Reply-To: <20250522074616.3115348-2-zhangqing@rock-chips.com>
References: <20250522074616.3115348-1-zhangqing@rock-chips.com>
 <20250522074616.3115348-2-zhangqing@rock-chips.com>
Message-Id: <174790594029.1733292.2362448733539179713.robh@kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: can: rockchip_canfd: add rk3576
 CAN-FD controller


On Thu, 22 May 2025 15:46:14 +0800, Elaine Zhang wrote:
> Add documentation for the rockchip rk3576 CAN-FD controller.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  .../net/can/rockchip,rk3576-canfd.yaml        | 86 +++++++++++++++++++
>  1 file changed, 86 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml:51:111: [warning] line too long (153 > 110 characters) (line-length)
./Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml:55:111: [warning] line too long (159 > 110 characters) (line-length)

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.yaml: properties:compatible:oneOf: [{'const': 'rockchip,rk3576-canfd'}] should not be valid under {'items': {'propertyNames': {'const': 'const'}, 'required': ['const']}}
	hint: Use 'enum' rather than 'oneOf' + 'const' entries
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
Error: Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.example.dts:36.44-45 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.dtbs:131: Documentation/devicetree/bindings/net/can/rockchip,rk3576-canfd.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1524: dt_binding_check] Error 2
make: *** [Makefile:248: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250522074616.3115348-2-zhangqing@rock-chips.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


