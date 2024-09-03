Return-Path: <linux-can+bounces-1330-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCDE96A297
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B58A283005
	for <lists+linux-can@lfdr.de>; Tue,  3 Sep 2024 15:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8471C18BB9A;
	Tue,  3 Sep 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bznjIomp"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDEF18BB8E;
	Tue,  3 Sep 2024 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377072; cv=none; b=HgxP+z52Ce3NTuGjVI1EznYGQN1UFoJL882qwJfIbWx7ZRx9/OzbWloFDng8CnWhm56vK+sbqDnOaLXtbRuNKxrkcmsMI8Zc1Hsm2T1H+idTTFTr6I2CaZ+VFYM8w938OMC0CvwxGxVzGYEkbMmud+CIBpm5gUelTeqVhLgoevw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377072; c=relaxed/simple;
	bh=kres4qmVQiUAC82Fw/U24MiMZlV5tGiD9Eik6aD/+iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3KPGBegDgWe36xbylcyI/aNqovDBqpnm5Fgdppkl+nxVK7ZvjlzZTymupMDSNBzJ+FBga4hN3zGEbjNSx1jYhVHnYLLGNEalh8gMGZUVVVcoeu6eMttTcT3A9c854sgOKqmO9AXzFl/GK8VhzupPLV9LnwL7rucDVQS2f58xe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bznjIomp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EF3C4CEC4;
	Tue,  3 Sep 2024 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377071;
	bh=kres4qmVQiUAC82Fw/U24MiMZlV5tGiD9Eik6aD/+iE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bznjIompBK9BA2TvhAJfHpGomtTx08S5A79wlP+DjMrapy4sMI9hKABBMwuIK5+WB
	 ocEXuRhP1YD1c5C7dM0gcQtVPYysdqeanMmeDfIeFxQHPY/AjRWKe7+Y8izi6x9j1c
	 LwseNG3OSBaTL5A9QUlu7QFU4g1P6MvuKRPlNooK5mmmhnfh61fMh4bSQeHlHLYcRq
	 5dEeMUEEb8cckFf/l7JcLonAN5w8GhSDlDexKnQD/2CW05vk5iRZvEkvxLhiWdZx7t
	 nrSfQ5tVQBTAk8pkBQYBd3k2mzZHVIka+uwO7iJpDGpQkl8wlrBppvpc5HFsjXYcip
	 +26x7Uj4G3Vuw==
Date: Tue, 3 Sep 2024 10:24:30 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org,
	David Jander <david.jander@protonic.nl>,
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
	Simon Horman <horms@kernel.org>, linux-rockchip@lists.infradead.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	linux-can@vger.kernel.org, Alibek Omarov <a1ba.omarov@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH can-next v4 01/20] dt-bindings: can: rockchip_canfd: add
 rockchip CAN-FD controller
Message-ID: <172537706995.1043806.8906202359220781954.robh@kernel.org>
References: <20240903-rockchip-canfd-v4-0-1dc3f3f32856@pengutronix.de>
 <20240903-rockchip-canfd-v4-1-1dc3f3f32856@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-rockchip-canfd-v4-1-1dc3f3f32856@pengutronix.de>


On Tue, 03 Sep 2024 11:21:43 +0200, Marc Kleine-Budde wrote:
> Add documentation for the rockchip rk3568 CAN-FD controller.
> 
> Co-developed-by: Elaine Zhang <zhangqing@rock-chips.com>
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> Tested-by: Alibek Omarov <a1ba.omarov@gmail.com>
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
>  .../bindings/net/can/rockchip,rk3568v2-canfd.yaml  | 74 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 ++
>  2 files changed, 81 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


