Return-Path: <linux-can+bounces-6388-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN5IJ8sRe2nqAwIAu9opvQ
	(envelope-from <linux-can+bounces-6388-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 08:52:43 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06710AD05E
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 08:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64C7C300461B
	for <lists+linux-can@lfdr.de>; Thu, 29 Jan 2026 07:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D194637AA88;
	Thu, 29 Jan 2026 07:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="XcyZ0P62";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="nJC6m8my"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2F37AA71;
	Thu, 29 Jan 2026 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.160
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769673159; cv=pass; b=ph/KUb5dSIXSOy+SSlPIcoA2+usbl45/CKLzHICRYzzBc7LAW+GLwFGzEVphf/CXvtBbXUkvqUphUb1HLxkx2V7IX0uHxH9+qd+ourwYwsdcu4fUMWvXVx/sUbgi/Um7Gj/5ppsFHDfJZyj5SPof5r+xdmbz8+qLXsxEC/Gp+Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769673159; c=relaxed/simple;
	bh=KPZ3RT8p1UvPX0aNTW40NX4V+qmWEGgwkM/A1+r6nNM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PmUzNluRei6kWdzB+mZJMl9zRlUNgDDvdbO/AkOJzY73xVWrnvs7qUx8pxpdpOivgfxqq8hWcJjCPAuPlwKUT8bA9NjkElpVYfWIKHShTmpJsES+h4nZb4uJwjeS7Z1cSP0DPkVMg6MQQbaCUjlOHj5Y9hzRioIMq6CYcsh8abc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=XcyZ0P62; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=nJC6m8my; arc=pass smtp.client-ip=81.169.146.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1769672970; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r1bLmwQcw2duwxsvT0v8BWosgehEoAGFzn9hDYRiGIEad11wgpJrmOS9cddeOErvgl
    aeHtJ8YDLuZmMl71pvXZoNwP1COoCTUjceL4g+zVSeE8ob7Z/f/78bl8W6vzQ3FPBE2I
    xEZvaBV979aYIHWvMXJWImkyqolsYlpveAbp5O77P70Y3s4KWfRBEGB4aem+y/Aucbge
    ApU0chUwmdsgZNa/Uj7R4eB/JGipCVGWq3Uc9+1Sah0/4o52brcizJ7ikEsgNqO3er4h
    1wnRY0v0Z/a/3PizvKzzFnhdb0BLbAxPY6FheClnBJCvs1jSCTNpHxT4aDuWapjNLa2P
    TcWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1769672970;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Z+WqTAg9LUbI0GhBY+6VoNRxElDKvMCBB5g8TUsqTbY=;
    b=fp6f0CHBB4GEfr7QVw5VJzKKO/WZ4pI6tr/7p9dPX6BTHepFA2pL4E3y+vTnxg0iJ6
    rDQkKk+CzC1vJCDY5O/l5yMc8FelLGWZTbcxjiYYGDWPfye75YfUow0CC6wGPDW+WAEx
    TrcXRbyCYteb4X3r37yU4OUuiMY8A/56rRlIlBcZKluON8TPvQWk8w/OoX4c5jJn/mC+
    CknsFiVVo4Bo+403CYEM1WQFjkCvF+w0YrhPdeDzHzPwhvS6Vx8BRK+xFdLtd2D1CKxF
    Wq9c++7nVdkAxbQ60tlKsezscXxAKhj+1py0BpxV3nkDLdpeqdN+XpfJFLbiOuwQkbxe
    Ueig==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1769672970;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Z+WqTAg9LUbI0GhBY+6VoNRxElDKvMCBB5g8TUsqTbY=;
    b=XcyZ0P626blEtjlCbtDxdsEpEEon6OZ6yqnfBKtbj/5bqnRY1RDYfEOgzEaX9KOwHZ
    Par1esuC1RVQkpPtCrFACa9iIBubEOeKk3CuCvU7aeP5LuqRsPoONOjjWSNLh0P5ZS1x
    9I4dDhcxn+SSoYluY2pFFL/wHNrPomE6dVXIGlETpFWZma9R93pz3ws8YUJEdge48A9t
    wMgDf/DZ8d0ew+qxfY2zOT5N5NV7zGtBw2NhhSqM+wsIC64Jp+NwEKn0MI5gkA/u8wOP
    T73d9FGsNrWUeXXKo0xczbX4yP2as1ltnpx0G/XbHZPgkcLrLBwcP7lV5BzCH3DCTLYY
    +B6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1769672970;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=Z+WqTAg9LUbI0GhBY+6VoNRxElDKvMCBB5g8TUsqTbY=;
    b=nJC6m8myKdhaJqhsMIGI1Q3KBTE9SgMgbkfn4Q/i5WYS7jNrQLoWcOjYruKVLMQ+1B
    GNHCI0IAwgaMbfH2TbBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8YjX10Q=="
Received: from [IPV6:2a00:6020:4a38:6810::76e]
    by smtp.strato.de (RZmta 54.1.0 AUTH)
    with ESMTPSA id K0e68b20T7nTpwc
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Thu, 29 Jan 2026 08:49:29 +0100 (CET)
Message-ID: <f47126ee-8256-4077-a09c-47a1ed461f65@hartkopp.net>
Date: Thu, 29 Jan 2026 08:49:24 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 0/6] move CAN skb headroom content to skb extensions
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-can@vger.kernel.org
References: <20260125201601.5018-1-socketcan@hartkopp.net>
 <20260127174937.4c5fc226@kernel.org>
 <67cb17f4-2f72-4847-aa04-3633f3d8df33@hartkopp.net>
 <20260128-booby-of-phenomenal-proficiency-4db5ab-mkl@pengutronix.de>
 <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20260129-versatile-tuscan-mongrel-f9b173-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,none];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6388-lists,linux-can=lfdr.de];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-can];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[get_maintainer.pl:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,pengutronix.de:email]
X-Rspamd-Queue-Id: 06710AD05E
X-Rspamd-Action: no action

On 29.01.26 07:44, Marc Kleine-Budde wrote:
> On 28.01.2026 10:07:13, Marc Kleine-Budde wrote:
>> I'll do. In the mean time, please have a look at b4, it has support for
>> sending patches via a web hook.
> 
> Hooray for switching to b4!

Yes! Unfortunately one of the most relevant features does not work:

$ b4 prep --auto-to-cc
Will collect To: addresses using get_maintainer.pl
Will collect Cc: addresses using get_maintainer.pl
Traceback (most recent call last):
   File "/usr/bin/b4", line 8, in <module>
     sys.exit(cmd())
              ~~~^^
   File "/usr/lib/python3/dist-packages/b4/command.py", line 417, in cmd
     cmdargs.func(cmdargs)
     ~~~~~~~~~~~~^^^^^^^^^
   File "/usr/lib/python3/dist-packages/b4/command.py", line 83, in cmd_prep
     b4.ez.cmd_prep(cmdargs)
     ~~~~~~~~~~~~~~^^^^^^^^^
   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2835, in cmd_prep
     auto_to_cc()
     ~~~~~~~~~~^^
   File "/usr/lib/python3/dist-packages/b4/ez.py", line 2655, in auto_to_cc
     logger.debug('added %s to seen', ltr.addr[1])
                                      ~~~~~~~~^^^
TypeError: 'NoneType' object is not subscriptable


$ b4 --version
0.14.2

While get_maintainer.pl itself works ...

$ scripts/get_maintainer.pl net/can/bcm.c
Oliver Hartkopp <socketcan@hartkopp.net> (maintainer:CAN NETWORK LAYER)
Marc Kleine-Budde <mkl@pengutronix.de> (maintainer:CAN NETWORK LAYER)
linux-can@vger.kernel.org (open list:CAN NETWORK LAYER)
linux-kernel@vger.kernel.org (open list)

At least posting via b4 relay works fine and downloading of the v2 
patchset you sent was comparably easy too.

Best regards,
Oliver

