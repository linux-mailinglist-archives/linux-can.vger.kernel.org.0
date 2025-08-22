Return-Path: <linux-can+bounces-4330-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D782FB31C38
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AC211D27A1B
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 14:36:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D52FE563;
	Fri, 22 Aug 2025 14:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sDgxtLvL"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3879271464;
	Fri, 22 Aug 2025 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873351; cv=none; b=R5DlppXqQ46NcEoFApicvOz+3A97D/I0s+diZE/G5mjp9tv/qQI5swJAu9Yojw+Eljahe4L3qHBSIGliNy5dzL+VPVgVzxkkQ+a7qqsfP/YWZ8p3KYQLFuObPIrKNDxfcQxe1r5YZ4ULszo5EahqK4/wrrzDBgd96/vqK28sT+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873351; c=relaxed/simple;
	bh=xbIWt5zJF7zdNnuu196XkwfuvOFHej9VtwDilSlX6XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bS/iRgv69QcPr2dH5gT4oz7jscX+rdhW1VkeQ9S8JRy6MiYAUHNfGwmIH3kP30oiNWrAVhDnFU5zBit68+4NwTqUYAXlJSDbDPvyefP69BJl3H5BnhIm8+ZXsdcyY0KyHXfnOr2HQVLxK8wuVKbnDdxxkBtj1EDSZqQ5FZ3oQ8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sDgxtLvL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8919FC113D0;
	Fri, 22 Aug 2025 14:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755873350;
	bh=xbIWt5zJF7zdNnuu196XkwfuvOFHej9VtwDilSlX6XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sDgxtLvL2pUG6pnfqCzV6aJ2U8QyW0tI6fToE1Uyrt+usjeD5n/ZKtHMzH2KwduzN
	 4UaPrFcsPSsgJrC9TFy91xI5uzN3MaKa9RHkM6Lnn0twbatPeIIs0k2tHlfI6ZlxtN
	 7A816v4Y7r70HhHmjyUdFw3xGiiXNphf7cxIngHVQ1mw4ydNqOB2GHz0h3X2TZRQs/
	 6Gb4OQ85DjYBmV4VDBA7L9YdeUfMlaWx0G7DLF0tSrues778QXUJlG8e4kxus9egMe
	 EQOmq3j9wqJwteKpiISOfVM6X2eHBIjXunBBjkjyKrop6r15rPjre1GaTRcGt3RXZ+
	 1WHWOtrGfHksw==
Date: Fri, 22 Aug 2025 09:35:49 -0500
From: Rob Herring <robh@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vishal Mahaveer <vishalm@ti.com>,
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>,
	Simon Horman <horms@kernel.org>,
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
	linux-can@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20250822143549.GA3664230-robh@kernel.org>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
 <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com>

On Wed, Aug 20, 2025 at 02:42:25PM +0200, Markus Schneider-Pargmann wrote:
> The pins associated with m_can have to have a special configuration to
> be able to wakeup the SoC from some system states. This configuration is
> described in the wakeup pinctrl state while the default state describes
> the default configuration. Also add the sleep state which is already in
> use by some devicetrees.
> 
> Also m_can can be a wakeup-source if capable of wakeup.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f25378bb2cdef034dc4e6b 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -106,6 +106,26 @@ properties:
>          maximum: 32
>      minItems: 1
>  
> +  pinctrl-0:
> +    description: Default pinctrl state
> +
> +  pinctrl-1:
> +    description: Can be Sleep or Wakeup pinctrl state
> +
> +  pinctrl-2:
> +    description: Can be Sleep or Wakeup pinctrl state
> +
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the default pin
> +      states. Other states are "sleep" which describes the pinstate when
> +      sleeping and "wakeup" describing the pins if wakeup is enabled.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: sleep
> +      - const: wakeup

This doesn't allow '"default", "wakeup"' which I think you want.

"sleep" and "wakeup" seem mutually exclusive and really are just the 
same thing. Both apply to the same mode/state. Whether you can wake from 
it is just an additional property (of the state). 

So I think you want:

items:
  - const: default
  - enum: [ sleep, wakeup ]


Or you should just drop 'wakeup' and just support wakeup with 'sleep' 
when 'wakeup-source' is present.

Rob

