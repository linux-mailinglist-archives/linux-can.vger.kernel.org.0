Return-Path: <linux-can+bounces-5470-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9072C65B72
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 19:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 9A19928B29
	for <lists+linux-can@lfdr.de>; Mon, 17 Nov 2025 18:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2AD2D6E64;
	Mon, 17 Nov 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4JNfmpC"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE99268C42;
	Mon, 17 Nov 2025 18:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763404067; cv=none; b=OZhNoZQcocVI/ruFFHRFJKpnSN4rGG8rvekznX7Ws6mXRz/78GKhOzmQ7qYOK+EGKgpPXJehqpvX4Z5DpuriJ8/PT4iTX47Qp79MLZjg+eZ/xazXyV5VmNqK0yAKCIDX2IVP7Qo9ooc9JqUS6qB+4KO0coEfhJWy1CbeVKRZygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763404067; c=relaxed/simple;
	bh=KgWGDtm7Lix+RRL3J6skSv7OaO3bi5ZBiY3XQ0yIU/s=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=jY+PGbfJufhDRIqSKO1sHM4Qw66pzFlcpEoUp9yz/F1jlrgn2HSgMx6uovnYDZlz6elzls59djRaF7wsWzBnvRCpbRzs5xig9cyihHtWIi+Yjmc1BUh4mlIYM0zobDJnevtXPbQ3yYKwc2sxPf/1gUxZBGzzuRyqJAj2itpBlvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4JNfmpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F8BC2BCB1;
	Mon, 17 Nov 2025 18:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763404067;
	bh=KgWGDtm7Lix+RRL3J6skSv7OaO3bi5ZBiY3XQ0yIU/s=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=t4JNfmpCwKuVCmYdu9cVztWn9iyvXZS9loTn2vM3pB1nQgTmPISqZGejupmoyD+cO
	 MrVmKcRm/aarV0ejHW5T3vhKw65MvtdIEyDYCaJi/Or9xAVFkyiRTraUQvckhDVwVS
	 Nn1xCcXwAY4Z3p207Eo0p7XwkvotHG9vu3f5gHg+Kf3ha5sqqjqr8Kc6CYI5AcYWNK
	 JnV+LyZg85LiDnxpmMX8CT/zM0iaWzCuBaA3tfmWxfHWEgDdn6pIn+GWdzNQn6CXpy
	 x+JyeoTqqP35At36EHG4mwplB3ULvKFNCJOS3loNb3V4wFElgWZ7YbclJgwCH5n0FW
	 uKSTFmjPE7Neg==
Date: Mon, 17 Nov 2025 12:27:44 -0600
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, devicetree@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol@kernel.org>, linux-riscv@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Daire McNamara <daire.mcnamara@microchip.com>
To: Conor Dooley <conor@kernel.org>
In-Reply-To: <20251117-twitter-sternness-f2b3a1506a6f@spud>
References: <20251117-twitter-sternness-f2b3a1506a6f@spud>
Message-Id: <176340406423.422791.14985477842686606616.robh@kernel.org>
Subject: Re: [net-next v1] dt-bindings: can: mpfs: document resets


On Mon, 17 Nov 2025 16:38:18 +0000, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The CAN cores on Polarfire SoC both have a reset. The platform firmware
> brings both cores out of reset, but the linux driver must use them
> during normal operation. The resets should have been made required, but
> this is one of the things that can happen when the binding is written
> without driver support.
> 
> Fixes: c878d518d7b6 ("dt-bindings: can: mpfs: document the mpfs CAN controller")
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> This is the second mistake in this binding, both spotted because of the
> driver being written (although this one sat downstream for a while for
> w/e reason). I wish I could say that I'd send the driver soon, but I am
> busy upstreaming things I wrote and therefore understand at the moment,
> so a driver that I'd have to go understand and review before sending is
> low priority, sorry!
> 
> CC: Conor Dooley <conor.dooley@microchip.com>
> CC: Daire McNamara <daire.mcnamara@microchip.com>
> CC: Marc Kleine-Budde <mkl@pengutronix.de>
> CC: Vincent Mailhol <mailhol@kernel.org>
> CC: Rob Herring <robh@kernel.org>
> CC: Krzysztof Kozlowski <krzk+dt@kernel.org>
> CC: linux-riscv@lists.infradead.org
> CC: linux-can@vger.kernel.org
> CC: devicetree@vger.kernel.org
> CC: linux-kernel@vger.kernel.org
> ---
>  .../devicetree/bindings/net/can/microchip,mpfs-can.yaml       | 4 ++++
>  1 file changed, 4 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.example.dtb: can@2010c000 (microchip,mpfs-can): 'resets' is a required property
	from schema $id: http://devicetree.org/schemas/net/can/microchip,mpfs-can.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20251117-twitter-sternness-f2b3a1506a6f@spud

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


