Return-Path: <linux-can+bounces-1268-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80331966A42
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 22:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C762846A8
	for <lists+linux-can@lfdr.de>; Fri, 30 Aug 2024 20:16:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829731BCA08;
	Fri, 30 Aug 2024 20:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YNy+ey6I"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A9EEC3;
	Fri, 30 Aug 2024 20:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725048966; cv=none; b=BVNBffGQ+NmauwaWaBN03pSA2fpPNIYUtbiE/ZZZ7o9MrbuR5qw5t7D/eHzym0wEb0M8mQ2L8bt8EtYM5VZu7UVuul1rt7N9Aq9GwqGhRxjGsKNSm2ormv29bQ+VskJUMHUn167i2RxrHVKORCwdhbGYz/AE1yPXPlzjgtM+gmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725048966; c=relaxed/simple;
	bh=BHJAPCRkkwvBrJQihBZsj9YydNkC0N902Xxm8U4CrfE=;
	h=Date:Content-Type:MIME-Version:From:To:Cc:In-Reply-To:References:
	 Message-Id:Subject; b=iQw2A9jPM0Zh3zFaf/KuciVf9Q0HJJI6i8mcrq4Ik3g16IGtylSMOY3CvGMQ8ONhmwRCiITmpeky/0BblnsUT1TxseuvgXaSZsJ9peqgRTyNqXQoFD/XZQqZDb1XXLtDR7nVtkhKnBSLw3MEo/DL8iOnr2TUJShF1jCFTX6cyAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YNy+ey6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF73C4CEC2;
	Fri, 30 Aug 2024 20:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725048965;
	bh=BHJAPCRkkwvBrJQihBZsj9YydNkC0N902Xxm8U4CrfE=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=YNy+ey6INHaAq9MsgntpjXQRnsDtR4mQxaT5mip9SwXlpm49c7B5zp9PkHSqyPx+b
	 AwMLMRu0e3WmZ3ZhpSPb6+xqc67eCDC6KidvQPHC8PV4+bwl/Q4h2v7nJoES2QOszJ
	 bCVw9kWyVi0mhWJf6yeQsmlhORy47rpMoyJiGyvZIpNAahjD78TJf1ONtCa0LCI+wG
	 TvXRYfI3/F8Bro8sv/+QV4179CosziWun+hm+KkkU4dHYkIl2UcPDEnGuuy45lvgv+
	 xB0UqtTuGn5ikLwp364HDjVLCgG0ZPyilgdFDMxyrkpxPVs785/RRVRH1rb2EebrZt
	 hkVENzPwrWwmQ==
Date: Fri, 30 Aug 2024 15:16:03 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Jander <david.jander@protonic.nl>, 
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 Heiko Stuebner <heiko@sntech.de>, Elaine Zhang <zhangqing@rock-chips.com>, 
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, linux-can@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, devicetree@vger.kernel.org, 
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20240830-rockchip-canfd-v3-1-d426266453fa@pengutronix.de>
References: <20240830-rockchip-canfd-v3-0-d426266453fa@pengutronix.de>
 <20240830-rockchip-canfd-v3-1-d426266453fa@pengutronix.de>
Message-Id: <172504896361.968651.6212275556677921387.robh@kernel.org>
Subject: Re: [PATCH can-next v3 01/20] dt-bindings: can: rockchip_canfd:
 add rockchip CAN-FD controller


On Fri, 30 Aug 2024 21:25:58 +0200, Marc Kleine-Budde wrote:
> Add documentation for the rockchip rk3568 CAN-FD controller.
> 
> Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../bindings/net/can/rockchip,rk3568-canfd.yaml    | 74 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 81 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/net/can/rockchip,canfd.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/can/rockchip,rk3568-canfd.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240830-rockchip-canfd-v3-1-d426266453fa@pengutronix.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


