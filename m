Return-Path: <linux-can+bounces-1968-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5449C4ED5
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 07:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5299A1F24EB8
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 06:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4134A208962;
	Tue, 12 Nov 2024 06:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b="1kelb72c"
X-Original-To: linux-can@vger.kernel.org
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A3F5234;
	Tue, 12 Nov 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.30.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393562; cv=none; b=TDQlyNNn5kpVnTTFDasEQFwD918Cd7UrmTTpuSmzikEOfk1kpYyju61GRNFds9qB6gRAe2LkI2Pn3KJxNkoXsDpFzqu4it6xDI7wRcDmZjyyc0s67/K5iPQqCBjMi2AjcKS++GGOLLgvp/bWrygw0HJqp37d5r7HcH7U+58XwMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393562; c=relaxed/simple;
	bh=qBZiGi1u8iJrl5166Fw1rBfClz9HCNwg6W87v0hoOjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYRjnFXcqHnFzvei560eSnB9sRqgzA+OSJoiVkDLfTqTb85RcwQZpsAID2SSouRpDUtx5RtIK/k8d+PSXMttxaO9KWO3bbEPk6gFXD0Mk6wa8i+te3KcHSyaO1bg0TXRTJ4eY0Cg0Yi177U+CT7oxvwfjl2CSHCn2/Aa0Bt6WAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com; spf=pass smtp.mailfrom=geanix.com; dkim=pass (2048-bit key) header.d=geanix.com header.i=@geanix.com header.b=1kelb72c; arc=none smtp.client-ip=188.40.30.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=geanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=geanix.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
	s=default2211; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID; bh=DMBzvsCGMw6qfR4K0jMLHbUMUuG0vgDO025DsOZ7Tv4=; b=1kelb7
	2cZXNysGmHSwC/aAZ3zikdKshn2km2x26JXQmwIFkM7DW+8QFicJmIRj+H27B7GWoqzBe6dGEB6oT
	RLLhp5Zc700i1weTf+Ws7UZaHO6qKSRI7yb+0Yqzm8GhNq68efxk6e5wpGFhxuCODg6NEM5RRCP0q
	pxT7yOwnioffiuInvyjvE9RE8KWolPRHdp8HAyzCxJtRvEcv4WYQuw4hGri6RZ594X+U4rFuUyw7A
	TZlziQoYgVPuN1vEeNNz+bzs26SQuRht2lboFIG+H0x/yyM0NqEwdORtSEdO02NH+CftX8uIaBdQb
	i4ciYB7NfaIzufyyDC/RdHK91i2w==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sean@geanix.com>)
	id 1tAkYU-000Giw-5O; Tue, 12 Nov 2024 07:39:14 +0100
Received: from [185.17.218.86] (helo=Seans-MacBook-Pro.local)
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sean@geanix.com>)
	id 1tAkYT-000NhT-1L;
	Tue, 12 Nov 2024 07:39:13 +0100
Date: Tue, 12 Nov 2024 07:39:12 +0100
From: Sean Nyekjaer <sean@geanix.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>, 
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-can@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/2] can: tcan4x5x: add option for selecting nWKRQ
 voltage
Message-ID: <fatpdmg5k2vlwzr3nhz47esxv7nokzdebd7ziieic55o5opzt6@axccyqm6rjts>
References: <20241111-tcan-wkrqv-v2-0-9763519b5252@geanix.com>
 <20241111101011.30e04701@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241111101011.30e04701@kernel.org>
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27455/Mon Nov 11 10:58:33 2024)

Hi Jakub,

On Mon, Nov 11, 2024 at 10:10:11AM +0100, Jakub Kicinski wrote:
> On Mon, 11 Nov 2024 09:54:48 +0100 Sean Nyekjaer wrote:
> > This series adds support for setting the nWKRQ voltage.
> 
> There is no need to CC netdev@ on pure drivers/net/can changes.
> Since these changes are not tagged in any way I have to manually
> go and drop all of them from our patchwork.

Oh sorry for that.
I'm using b4's --auto-to-cc feature, any way to fix that?

Br,
/Sean

