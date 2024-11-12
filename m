Return-Path: <linux-can+bounces-1976-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E44E89C5038
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 09:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CFE3B2C17E
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F49820C481;
	Tue, 12 Nov 2024 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="xMIXRiN2"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4075620A5FB;
	Tue, 12 Nov 2024 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731398010; cv=none; b=pmmCnRjm4ITJsVNMoO0IZfor25JKBR5qf6b6zAJdB7VMbfxEqUy+cgQpz8ve6n2bH+2noU+amLsDXkD55ca3YeJYkqtkdGywT8ggpRCYI4k0wY0WpStpOCO936kocx0vPd0SJO0OSx7SGulujM0P6DkXWEOOiKSaMESvqVkYWUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731398010; c=relaxed/simple;
	bh=Ya9WJPZN2OZYUG7WeVzwc7TbneVeAAM4iyiHiQz6I44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGjkXru4BAoRTr10h5LSXMNID5bZnqGRJG/8wvIrr/HZVt0PHYUVRgBwAqcuQB1gugaYmyde49fSlX3rrVFxgGYvMiafz8FxMHZjjK+l2VQmBqkfTzCuMGei1UWaS9V2nkMxgDM6N8yk0T/Y+ST3exwUAls+O1W85bokMVbORko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=xMIXRiN2; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=+CicQmBbCv29/xiHgnZ+Z8sv1AVWbLap/TSIARQnGHM=; b=xMIXRi
	N2PIo5n168pq6k9vmSSzzqCHxptA0SI+y5n3L0tCLIZhtm3a3t1ohY6ZTTm5RYUQtvbUWpojGNyPy
	Gsk8qzVA7l6Ebda2oGm9dFrT3D05OFPq3H5l220kmK2HYpx0jRavWoZUcGTgMvCG/+4J2vLLTRYKg
	BPGKkLH5kZWG2ZvlVOyX65GHfJnr3bphceIuQDkUnpJtRRNJYYXUqQ7m4BB/84gxp7cQOX0/eBCYP
	lG5hfGg0b3W3fknLd64sjDeMqhAEpbUA/W8LSMf0sObp1mhJ0a1MwvOBMLakF0BaXoqTgjFXgKqZY
	mWHody1XGZWgxVUmLN47IAbqDMcA==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAliH-0004Xm-8l; Tue, 12 Nov 2024 08:53:25 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAliG-000LDs-1k;
	Tue, 12 Nov 2024 08:53:24 +0100
Date: Tue, 12 Nov 2024 08:53:23 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <2ioqxdymcgx2tnz6cvcuibom6mwam32sushu7kv6bo4e6vemlf@m53nguyzqlyp>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241112-bizarre-cuttlefish-of-excellence-ff4e83-mkl@pengutronix.de>
 <lfgpif7zqwr3ojopcnxmktdhfpeui5yjrxp5dbzhlz7h3ewhle@3lbg553ujfgq>
 <20241112-doberman-of-original-discourse-a50070-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112-doberman-of-original-discourse-a50070-mkl@pengutronix.de>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27455/Mon Nov 11 10:58:33 2024)

Hi Marc,

On Tue, Nov 12, 2024 at 08:52:14AM +0100, Marc Kleine-Budde wrote:
> On 12.11.2024 08:44:00, Sean Nyekjaer wrote:
> > Hi Marc,
> > 
> > On Tue, Nov 12, 2024 at 08:38:26AM +0100, Marc Kleine-Budde wrote:
> > > On 11.11.2024 09:54:48, Sean Nyekjaer wrote:
> > > > This series adds support for setting the nWKRQ voltage.
> > > 
> > > IIRC the yaml change should be made before the driver change. Please
> > > make the yaml changes the 1st patch in the series.
> > > 
> > > Marc
> > > 
> > 
> > I know, so I have added, prerequisite-change-id as pr the b4 manual.
> 
> I mean the order of patches in this series. First the yaml patch, then
> the code change.
> 
> regards,
> Marc
> 

Oh, noted thanks!

/Sean

