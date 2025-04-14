Return-Path: <linux-can+bounces-3397-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE33DA88BDD
	for <lists+linux-can@lfdr.de>; Mon, 14 Apr 2025 21:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAA76189AE9F
	for <lists+linux-can@lfdr.de>; Mon, 14 Apr 2025 19:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F617279785;
	Mon, 14 Apr 2025 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="I0EauWmK";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="G17ucTpM"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDDA261575
	for <linux-can@vger.kernel.org>; Mon, 14 Apr 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.161
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744657198; cv=pass; b=AWKBWwe6wuqH1pipLjTaaGJNyFXGox55GQig8g8FYxMebg6QKreBObecMiPMPY0Tt6u4Wu8ye4zu1uC1bxIyxpRzXJFQwyUbYdioL/TDTKoT98c1t9ugFVCwf+yagAoqFrAnjku7PMZta1JdrFd/q9ROODzLz44oQpkMeXH7OMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744657198; c=relaxed/simple;
	bh=iA9dBh3yS1pd7W130y6Vz87SxXfBgCBIWQ0MM6LoMRs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oauy3HaECCan/CvBn8XUeSnGX0JrTQCSignMjfE64X799vma2krWu4kp7VujUr+vZC21Bzszl8JG2c8oE03+l5L4iLTt8+FDiT2Rbz/9NIL3vweHIoRrZXMeSpPA0mO78KUG8TghN7Ny52xlM8YO6d4L8unnVdkl+FFOjKtW28g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=I0EauWmK; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=G17ucTpM; arc=pass smtp.client-ip=81.169.146.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1744657003; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ldod1QWK/WoYDt4O/hRjvaoRAPQuDEdsJ6zXRTuFdfr3YZM6hRTiALPWQsIg8KKepc
    XpfQGFWyUD5GxAhv4Hjktn222HOhE00oq//bToIjIvrlgG8Tq/jnQ03jmhLfb9DiljTO
    KN2TBCPpmw1bxtH4GZfRH14Zd1OFnAkEC5qHd/p8LHnUsvBpNBppz+veEbCE5scGNkTy
    F54KkDMJ7snBsLYc8dA1z6DdKLPxl5QZu7p5PVf48+I+QNBEb9m1yd5fBcEZ3dBvXypw
    T/3hbDvHAYA2BwoCa+npDQ3v79vIcKHQ42duYNmULlGSJuswE+xeaShQpC6DY6VxS8+E
    JYdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744657003;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eST8mwUwoKK+zf0KjC8oA/+fk9Qtp8nAG5+5r7AQAXs=;
    b=cgS86DevvUrydbFGlQHAU9m8Qafipl8CgL4MI3Hdk4HmaylLBJToiWbsuCmXWVpsDs
    9uVKoEjGL23ma2+LkDruPlReAOPdFSpJAKwbn1nJ4Wg4nxePCpj4o8/PYxQeFnVFkBIx
    T0GUBi72isz8EBTRzu4BsIAdb8RvSC+QuTApHmOUX3tW16f343wx2fz94l43H5xbPCJr
    yykW7wfTZPY1WF7qKQ+Wzt5quIAmhQhnFpZnJK5vQyBFD7yn9M9DkZ3BNDdsW4U2IYfe
    WBAp/ffVuksapCfyb0Kr/oTkvOCYUkW7jixBQvGmbTbGR5bZm9FDifUGH+8r2gW3wJFI
    geeA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744657003;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eST8mwUwoKK+zf0KjC8oA/+fk9Qtp8nAG5+5r7AQAXs=;
    b=I0EauWmKykv+BEWs3VjYnODNiu/x7RN4WuinXN5enw8Pp0MGBGMA2/ESKyM6VC8+AC
    LQPy87FFM1ewuI4NbBN+Bdg2gb/1YlgV0eoIU1uF55btzXQorQnYgL2VUqr224Ri/F6k
    VlaiDN5KqK3UVJmwxLuWZCz7AmEagDRNQXXcn152m2uNvytheFrafKKOYG2JEcu1RQBA
    XlMV53/vf4p1eESZea+pemea7WbvidEkWA3wyZaJyu4hfp+GaEGqd62k4NzzWBUj2C32
    7PDe6NYfvdPnTNBbCiQbozMFpFKVolKPJikfYCh54hFBM2WsABnwFyPcp9iNXui+5MwX
    xgvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744657003;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=eST8mwUwoKK+zf0KjC8oA/+fk9Qtp8nAG5+5r7AQAXs=;
    b=G17ucTpMjBQKJp+MB9uMOjQgHhGYn9UTFF6ySgV06zaGp5VVZIuENsuAHF5XgWdc96
    XuRA2TQw5pzLej1DjvBg==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+5xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5000::9f3]
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id K2a3e513EIuhMj4
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 14 Apr 2025 20:56:43 +0200 (CEST)
Message-ID: <f8d8c706-a44f-49b2-b75d-bd35066b47d3@hartkopp.net>
Date: Mon, 14 Apr 2025 20:56:38 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: fix missing decrement of j1939_proto.inuse_idx
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
 linux-can@vger.kernel.org, Oleksij Rempel <o.rempel@pengutronix.de>,
 Davide Caratti <dcaratti@redhat.com>
References: <09ce71f281b9e27d1e3d1104430bf3fceb8c7321.1742292636.git.dcaratti@redhat.com>
 <Z9qJ7_MGJgzXlUcj@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <Z9qJ7_MGJgzXlUcj@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marc,

we are already in -rc2 and this fix is still missing upstream to fix the 
protocol counter introduced via net-next.

Best regards,
Oliver

On 19.03.25 10:10, Oleksij Rempel wrote:
> On Tue, Mar 18, 2025 at 11:21:41AM +0100, Davide Caratti wrote:
>> Like other protocols on top of AF_CAN family, also j1939_proto.inuse_idx
>> needs to be decremented on socket dismantle.
>>
>> Fixes: 6bffe88452db ("can: add protocol counter for AF_CAN sockets")
>> Reported-by: Oliver Hartkopp <socketcan@hartkopp.net>
>> Closes: https://lore.kernel.org/linux-can/7e35b13f-bbc4-491e-9081-fb939e1b8df0@hartkopp.net/
>> Signed-off-by: Davide Caratti <dcaratti@redhat.com>
> 
> Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
> 
> Thank you!
> 


