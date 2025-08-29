Return-Path: <linux-can+bounces-4394-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D21B3BCD5
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 15:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD37563B16
	for <lists+linux-can@lfdr.de>; Fri, 29 Aug 2025 13:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AEB31DD92;
	Fri, 29 Aug 2025 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u21tUjf1"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2639C31DD88;
	Fri, 29 Aug 2025 13:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756475461; cv=none; b=Ub0PET7YMSE51Ogk7+zuij2r9JKiC58LJ+YcDxDQ5jewUZkJdbUFJqmeyaaQCV+0p9IAUguhuXqa8LSo0vcur+f+UTxrA6/CcZTu6tdzH3eFXsseuSdHemdCFB0jQ50L1k+6pCrpnkPIPiKXdowQSBAsyOeMXMzShd0WAgm0njY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756475461; c=relaxed/simple;
	bh=OBzkyZTISMayaZ8Cyos03TZvoAM7tbY8jXJS1KHHvT4=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=X+93kQVmq5CYLZeU0on5JdWPYK0SnEi03BOIE7cb6nSky3k49KB+pC1PBNfYYAoYSuMNWRVmSFL+JVWOBJObWlwAToetY+kyvS7D3N9UWz8+8g5L3Yf+Rn2Z96fM3JCh5w+yCv2yanWbsVmx52ub3hFCkR31GmJwMMgD2glvypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u21tUjf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80197C4CEF5;
	Fri, 29 Aug 2025 13:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756475460;
	bh=OBzkyZTISMayaZ8Cyos03TZvoAM7tbY8jXJS1KHHvT4=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=u21tUjf1YOV9Av9A5wWtcdnQyUAjgJgLyxbSAepV7rWJhKzFk51vUjB25yNuw7SJd
	 DnElto4V0p+hll6zA2pfaA6aL1+MAr8u+dPFDc8BZkCDx3gZ79QjmLVZY/56udVqcG
	 LGZWXcUU/Xq0TYJGUPr5monvH24ChEqHRBQM8qvyWwnw4lCYjr6ZhRLV1e4dz7IFjT
	 fjADXD2HEdMcrEyrrDiFyrLPdZU1CJNBpKG1vTkLd72DR0xHMUuOEo3vW05CZYKt66
	 uhaWnBZePm6d9wNCd8iZWhWwBqUvCKHUt3P47l5gkARcxF4c802b/89DWntc+RFHd+
	 ek6hUBDmJ4hjw==
Date: Fri, 29 Aug 2025 08:50:59 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: devicetree@vger.kernel.org, Dimitri Fedrau <dima.fedrau@gmail.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>, 
 linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
To: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
In-Reply-To: <20250829-tja1145-support-v2-1-60997f328979@liebherr.com>
References: <20250829-tja1145-support-v2-0-60997f328979@liebherr.com>
 <20250829-tja1145-support-v2-1-60997f328979@liebherr.com>
Message-Id: <175647456257.394630.17282056537152186661.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: phy: add support for NXPs TJA1145
 CAN transceiver


On Fri, 29 Aug 2025 11:19:58 +0200, Dimitri Fedrau wrote:
> Adding documentation for NXPs TJA1145 CAN transceiver.
> 
> Signed-off-by: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> ---
>  .../devicetree/bindings/phy/nxp,tja1145-can.yaml   | 79 ++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/nxp,tja1145-can.example.dts:21.21-33.15: Warning (unit_address_vs_reg): /example-0/spi/can-phy: node has a reg or ranges property, but no unit name
Documentation/devicetree/bindings/phy/nxp,tja1145-can.example.dts:21.21-33.15: Warning (spi_bus_reg): /example-0/spi/can-phy: SPI bus unit address format error, expected "0"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250829-tja1145-support-v2-1-60997f328979@liebherr.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


