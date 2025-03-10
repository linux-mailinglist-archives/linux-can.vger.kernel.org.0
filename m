Return-Path: <linux-can+bounces-3031-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFDFA58DF8
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 09:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE8707A4DAC
	for <lists+linux-can@lfdr.de>; Mon, 10 Mar 2025 08:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78461224226;
	Mon, 10 Mar 2025 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="domvwVM/"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486A3224222;
	Mon, 10 Mar 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741594860; cv=none; b=CGiBfFZBOppXNPG9V3RNpaYygyTjWPGYXUlO+nhiM9b2YXDdy5w6RRT4507fGAUim6Ie4FmBfH8x5Us2pYn0cQUZVqCGmIJAEd4kA+STuEw+89HLOjYJQM1crqEGxVG6PGIN7Ezv5siebfA8ywnydBHgrbmOA0aDrpyWtkAuZjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741594860; c=relaxed/simple;
	bh=el1rL8iBygMhoB5kwTVvjfVwI/TFyrebUfurth93Vi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G0kt1IXBKyTE+vq2GrpJAYPABNTQUaKJE6WuYvABQvIez+gUrMhvvJDOhNEfOLpE6GFeaNMjQjHk4Zxx25IKXZ2qJ5aXLFXOncuhkcU6zvr3dmcvBq3i2NzmMBhgovT/xNIMMcddu49pYkkCvGtYfv0yW68TuxkKYfi1HhQonRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=domvwVM/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8148C4CEEF;
	Mon, 10 Mar 2025 08:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741594859;
	bh=el1rL8iBygMhoB5kwTVvjfVwI/TFyrebUfurth93Vi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=domvwVM/UD6N2tud3bU+GjIibogzVm5H4DD9kZotdvjMLLpxNWBJWwM5Ed2l1vR3B
	 /ZxXQWc/H2/lYhr+/gd0JcOKA0lKAbY/16UdDxdgRN+f7fmwel79gbOp3jIw/kYfxC
	 El0HxTZ/vA0zShCM+VOYJXqx5hGAEpPivlrBz8mXAQ60SgUlmr2voSLAti7a835wLd
	 6xs2dYwCwctmyYXhzwjyKZjxzKllfcothJP1hmBfaitHW9DjtczA58NFjMGm6AfESd
	 zsgyeFWSUeWrdJ/XAYVbwIDkFP7pszRczcSx6uoPUrEkmpjXvqoV+4/f3BJe2skRHJ
	 o7oayTbuzU69Q==
Date: Mon, 10 Mar 2025 09:20:55 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Markus Schneider-Pargmann <msp@baylibre.com>
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
	Santosh Shilimkar <ssantosh@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
	Chandrasekar Ramakrishnan <rcsekar@samsung.com>, Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
	Kendall Willis <k-willis@ti.com>, linux-can@vger.kernel.org
Subject: Re: [PATCH v5 03/13] dt-bindings: can: m_can: Add wakeup properties
Message-ID: <20250310-gifted-coati-of-sympathy-dabc5d@krzk-bin>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
 <20250306-topic-am62-partialio-v6-12-b4-v5-3-f9323d3744a2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-3-f9323d3744a2@baylibre.com>

On Thu, Mar 06, 2025 at 12:14:41PM +0100, Markus Schneider-Pargmann wrote:
> +  pinctrl-names:
> +    description:
> +      When present should contain at least "default" describing the default pin
> +      states. The second state called "wakeup" describes the pins in their
> +      wakeup configuration required to exit sleep states.
> +    minItems: 1
> +    items:
> +      - const: default
> +      - const: wakeup
> +
>    power-domains:
>      description:
>        Power domain provider node and an args specifier containing
> @@ -122,6 +138,8 @@ properties:
>      minItems: 1
>      maxItems: 2
>  
> +  wakeup-source: true

If this patchset depends on dtschema pull, then this should be narrowed
to specific type, I think. Otherwise how exactly your drivers are going
to work if this is just "wakeup-source;"?

Best regards,
Krzysztof


