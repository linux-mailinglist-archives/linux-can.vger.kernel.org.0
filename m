Return-Path: <linux-can+bounces-4658-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 066AFB5257E
	for <lists+linux-can@lfdr.de>; Thu, 11 Sep 2025 03:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22CF4634FD
	for <lists+linux-can@lfdr.de>; Thu, 11 Sep 2025 01:09:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBA218DB02;
	Thu, 11 Sep 2025 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="hehXzZHc"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE30B2AD22;
	Thu, 11 Sep 2025 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757552943; cv=none; b=t/y+yrFj6v/0jKBZe3dYY0lhfBOH+tEayueOJ0RA2rbuW0xyuBKr6JSIH4ggWaWVZMhIuYtANb5LqSY/qGWfYc/NdNtS1mIpN7FCttbFPpT56iURGATN9u6LIVvfcaRpqv22TADm6g/43SRR7FWphL9aRB6qEFVBgq1fscqHgBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757552943; c=relaxed/simple;
	bh=R0GnnVvbLQRW/twqc40DEoUJo6aMtOo76EEaZfqmJXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6VxFnC+gMRM0BIY/Y63Zp4XlNh1sM6R9RdubflgysP7vG3k7FmZ8eOAaztMrkNM3Y1VfvES7jI4JfeVhrvnOx1hL99A7sugHlaO1/usLbyMMAgIKGYFPMopxxWm0++M60EAhBupoekSF12+uM01o27NkYwmWBm/ku2eRQMmCXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=hehXzZHc; arc=none smtp.client-ip=220.197.32.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=CsNsiG3pc8pWG7MUbtRJFCqC5DA+Sce6zLpMwj1ZxEQ=;
	b=hehXzZHcto3G4TRvJ+zg/nlos1kK4ej4LIxxm7qsKs1H3wmwWPA2uD8ONtASQ1
	ZLIdo6sKL8mhnm0Rf0zMN+dd0euvQYtKTVrYttKUFtbh6Q+sXS3OeUn5PMnsumbt
	mpDcZDF4Tkqq5GuWpFKB7foki46XqiU/pXFOrAvMOs9Hc=
Received: from dragon (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgDnjyT9IMJo2QdfBA--.19610S3;
	Thu, 11 Sep 2025 09:08:15 +0800 (CST)
Date: Thu, 11 Sep 2025 09:08:12 +0800
From: Shawn Guo <shawnguo2@yeah.net>
To: maudspierings@gocontroll.com
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] arm64: dts: freescale: imx8mp-moduline-display-106:
 Use phys to replace xceiver-supply
Message-ID: <aMIg_PPSZehzEyJD@dragon>
References: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
 <20250822-can_phy3-v1-2-73b3ba1690ee@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822-can_phy3-v1-2-73b3ba1690ee@gocontroll.com>
X-CM-TRANSID:Ms8vCgDnjyT9IMJo2QdfBA--.19610S3
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU5l1vUUUUU
X-CM-SenderInfo: pvkd40hjxrjqh1hdxhhqhw/1tbiBAfFZWjCB7k19wAAs1

On Fri, Aug 22, 2025 at 11:20:06AM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Fix the can tranceivers to actually use the new phy description instead
> of the regulator tweak.
> 
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>

Applied, thanks!


