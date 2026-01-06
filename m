Return-Path: <linux-can+bounces-6014-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 135B6CFAF75
	for <lists+linux-can@lfdr.de>; Tue, 06 Jan 2026 21:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18475304A962
	for <lists+linux-can@lfdr.de>; Tue,  6 Jan 2026 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694BF3358AF;
	Tue,  6 Jan 2026 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b="qfkDLRXS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=valla.it header.i=@valla.it header.b="ahoIrKkh"
X-Original-To: linux-can@vger.kernel.org
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B57287247
	for <linux-can@vger.kernel.org>; Tue,  6 Jan 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.56.87.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732003; cv=pass; b=bv+O8L6sZOmBVPvOX3Bb5NLq0hpUSezCJnI0+4nFKq56zosol2MY1PWc1VVK+KUReqShTJ5EVVdW3gJsFBrMLSfRRyxwjUxkG/G1VhCruXWvKv/ug/7Ha9NNLagSiNP8gnI9OFaqqOj0NAgQH6HKRNaivH53AY4LuWiNtD1Ne3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732003; c=relaxed/simple;
	bh=QzvbJ8y7akSoxlfvziTyU2H26u+gdjsVcxPDRT0Vekc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAiSn3RkR02RpEEjzffg5/ArlWOXy3XIDTvvaq4ngjNZmgLHZkkZjhCOuoPyrqxCR/pzUA7gHrr6ounlU7GwHr0twLzlw8o0OF5bKiAOx7ooB+0zK5CFzjzEciLnlo5g6rlyKzu7hkt+EHyAIm18vUqm3GNcPx0/maBefHwQDsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it; spf=pass smtp.mailfrom=valla.it; dkim=pass (1024-bit key) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.b=qfkDLRXS; dkim=pass (1024-bit key) header.d=valla.it header.i=@valla.it header.b=ahoIrKkh; arc=pass smtp.client-ip=185.56.87.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-bdtp.prod.antispam.mailspamprotection.com; s=arckey; t=1767732001;
	 b=guKGQ9HkevExo4ekbfqoqLeiolqhfn9Fn0EUeuyGyHJ4UaD8S64A3sujyn2kDpSM4Bq864Dsd/
	  Ln5JgvWoi30YV9HjWWjVO8O0sdB4CyR2BMnXlYdH/TXPY5yg2o7JNUnETy/lO0ML+Z4dsZYkhs
	  Syg4B6ahVxyoauqvsA16E46OK0TK5J/wlg0oqziIjOZj3aGNNaRNfm5/SOnYdy1dK6HC2+2VE4
	  AzYGDz1V+tJYpoeZfIdjWmim6uCDlILvNDiqm4LCQHO+Yg4cc3fCbqE5NZh8Bo8ckjdZeY+uOZ
	  AICzNyDTuc+grbUBMYYn1TiEFU1bgFiFuSyWcWn43tU8qg==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-bdtp.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-bdtp.prod.antispam.mailspamprotection.com; s=arckey; t=1767732001;
	bh=QzvbJ8y7akSoxlfvziTyU2H26u+gdjsVcxPDRT0Vekc=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=Aq0y3FeuW1cPTQvFhGmGSEeiJ1h+oHHCsWG35d64m3VO7igXmGfjA/bc5bCKIpNsyVVn7nRomh
	  WfGJOAZqMj06xFkW0yONXHMYVEwUYfoKUUJXo+7PuxEnhRjdW8yM7moFoma1Sm+PeqsLas8pOf
	  wgGautWeeXX7yrNbucgx5g38z2CdCLP+fQacHC41RgvSj9HcHGZ+ucvYG213ZFaOYH7/4OmIfK
	  9cvLyIwICIVUGWCD3XFYS26KPTp3KkaCXoAFzBzmpLbJb9EHcHSjyTcl+n8xGpeeuFbTxKNPhm
	  ZUtkl7XlC7ERCLfZcecfCI5ChKaACSY5u03pRANoAZSxEA==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=Uf1wXDnZEtrch6jvGDnIRLXBqVcbuiKUoyldZJS9XMk=; b=qfkDLRXSY74yzM4uM2whS15htK
	1EwZ8LFhtfny6ug6q3Ol1zsaC9BKt22+pHfJedQ2/KIjoOBdqpJ8o0YxLk/Q1smD5ECYaiLLsXJlZ
	IcbZPQVJdlGxroFQKaEwJ8Qf+qHB8ejDfff1IpjbIOyxKsgDn/nUbAZagSZWnNpI6mZ0=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-bdtp.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdDqO-00000000y6z-14Y1
	for linux-can@vger.kernel.org;
	Tue, 06 Jan 2026 20:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Uf1wXDnZEtrch6jvGDnIRLXBqVcbuiKUoyldZJS9XMk=; b=ahoIrKkh5XvAojUYOjlLBHZJj9
	UwKnqiO5GWH0DmIGfHnZl6KzZzoKrvt0mxu34JRXe6dsQqeEckobi6Zf7Org+dq3JRjDFBxmAxZ+8
	9ZuhEFYl5boFi+ck9u6H3Ria/w1QvyyF2vQlHE5D94dXsDeQSF7O3d3f4XicSpNaj9Yo=;
Received: from [95.248.141.113] (port=63004 helo=bywater)
	by esm19.siteground.biz with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <francesco@valla.it>)
	id 1vdDq5-00000000DxZ-2mvq;
	Tue, 06 Jan 2026 20:39:37 +0000
Date: Tue, 6 Jan 2026 21:39:35 +0100
From: Francesco Valla <francesco@valla.it>
To: Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Harald Mommer <harald.mommer@oss.qualcomm.com>,
	Matias Ezequiel Vara Larsen <mvaralar@redhat.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@oss.qualcomm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-can@vger.kernel.org,
	virtualization@lists.linux.dev,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v6] can: virtio: Add virtio CAN driver
Message-ID: <aV1zB_fYQE_OBZm2@bywater>
References: <aQJRnX7OpFRY/1+H@fedora>
 <aQkgsuxa2UaL_qdt@bywater>
 <aTsE1VIk4V/A49HE@fedora>
 <aT7XAsTWr0_yyfx_@bywater>
 <aVLOPMmpvArnVAHZ@fedora>
 <aVLq1ibPcPHk-7Qv@bywater>
 <e5bc1353-ed3e-478b-a26e-0bb9a50b3863@oss.qualcomm.com>
 <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cf222cb-e6e3-4d09-a7d8-bc64b8e148bd@hartkopp.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 996fb4f3e48771fce6f4ba07a23cc385
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1vdDqO-00000000y6z-14Y1-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-bdtp.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hello Harald, Oliver,

On Tue, Jan 06, 2026 at 08:43:42PM +0100, Oliver Hartkopp wrote:
> 
> 
> On 06.01.26 17:50, Harald Mommer wrote:
> > > With the plain 'cangen' you are not really flooding the interface, since
> > > you are only sending a random CAN frame every 200ms. The only way I can
> > > reproduce this behaviour in a consistent manner is running from the host:
> > > 
> > >      while true; do cansend vcan0 134#00; done
> > > 
> > > which seems to generate the maximum amount of traffic.
> > > 
> > > This is not of course a realistic bus load, but is leading the system
> > > (at least on my setup) to a corner case somewhere.
> > 
> > I have no idea how long the shell needs for a loop, always used cangen -g 0 to stress the setup which is most probably faster than the shell interpreter, and sometimes did this for both directions (RX and TX).
> > 
> > Full load is a realistic setup. And even if it was not, if something stopped working or worse crashes torturing the setup this was a problem.
> > 
> 
> Yes. cangen -g 0 -i <interface> creates full load - even on real CAN
> interfaces. You can also generate fixed content if you want to omit the
> generation of randomized content. 'cangen -?' prints a help text.
> 

I agree with both of you - I was simply arguing that a plain 'cangen'
with no parameters is not really loading the interface.

For some reason, I was only able to trigger the unwanted behavior with
cansend in a while loop and not with cangen -g 0, even with fixed ID and
payload. However, I suspect the issue is a matter of timing and
coincidences rather than load level.

> Best regards,
> Oliver
> 

Regards,
Francesco


