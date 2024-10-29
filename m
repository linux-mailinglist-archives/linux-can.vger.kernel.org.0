Return-Path: <linux-can+bounces-1822-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE819B42BB
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 08:00:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50B0EB228A2
	for <lists+linux-can@lfdr.de>; Tue, 29 Oct 2024 07:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AE42022E5;
	Tue, 29 Oct 2024 07:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zVqbGtaV"
X-Original-To: linux-can@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720472022D6;
	Tue, 29 Oct 2024 07:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730185228; cv=none; b=NECC6SqPtFLcRdZAY6UDHFmeMIi2Gu0vntthabyKzRvmZMyxh/vfc97TC7De0okKMJOhLsFY1UF8u+ciXkjGa5h91CS87ApnhIDEN5vIWLoc7bkxPFerp9XakHepVG7kKgMlCKr9Gk7cn16ZeiGyZgnscFbbt8tDv5u3CLB60sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730185228; c=relaxed/simple;
	bh=zFoHBz9YnA+7aZ9GnZxgMIAgUhg4L55gdafk1d3Ixw0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqNwZ9LhRzszY+16EQ5pkKfMK+pfWWcPs7zANDuipAt7mzKi3DgIATYz0x0KT4IBvRkRgwPADAnKMikWT6lnIZ+2z2ZF7+brvydRcvFlrgsXvhDIumHrwjFchjwcSsCQ5haZ3gA7A0SHTVFOp2sWg41JQUF47EWmvt/1ey+qlzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=zVqbGtaV; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49T70AZo108569;
	Tue, 29 Oct 2024 02:00:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730185210;
	bh=D4ct3CvxUUnSvNxEudgCSRthDl/NoDac/oF8Y2JEJ7k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=zVqbGtaVXrjnoj+uKOsMu25ccE5aZNei8B+nK1bU0gR97IJC45L+zQCZp4fdYxdmS
	 v7BZz5qk28cs8BShWK6Ikxa0PsN2WkJxdtpFjdvfbwud/bh41a04w6yYeT0xXcQypV
	 Y2nT7zHXZiBSlrt3L+UTo8+1RCLlLkHw8JUG6gzI=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49T70Aum079437;
	Tue, 29 Oct 2024 02:00:10 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 02:00:09 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 02:00:09 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49T708cc091693;
	Tue, 29 Oct 2024 02:00:09 -0500
Date: Tue, 29 Oct 2024 12:30:08 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Markus Schneider-Pargmann <msp@baylibre.com>
CC: Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Marc Kleine-Budde
	<mkl@pengutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra
	<vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>, <linux-can@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        Matthias Schiffer
	<matthias.schiffer@ew.tq-group.com>,
        Vishal Mahaveer <vishalm@ti.com>, Kevin
 Hilman <khilman@baylibre.com>,
        Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v5 9/9] arm64: dts: ti: k3-am62p-mcu: Mark mcu_mcan0/1 as
 wakeup-source
Message-ID: <20241029070008.u23edl7hzuntp6aj@lcpd911>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
 <20241028-topic-mcan-wakeup-source-v6-12-v5-9-33edc0aba629@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-9-33edc0aba629@baylibre.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Oct 28, 2024 at 18:38:15 +0100, Markus Schneider-Pargmann wrote:
> From: Vibhore Vardhan <vibhore@ti.com>
> 
> mcu_mcan0 and mcu_mcan1 can be wakeup sources for the SoC. Mark them
> accordingly in the devicetree. Based on the patch for AM62a.
> 
> Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> ---
>  arch/arm64/boot/dts/ti/k3-am62p-j722s-common-mcu.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated

