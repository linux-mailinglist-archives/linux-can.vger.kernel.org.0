Return-Path: <linux-can+bounces-5326-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4038DC447C6
	for <lists+linux-can@lfdr.de>; Sun, 09 Nov 2025 22:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7CF564E648F
	for <lists+linux-can@lfdr.de>; Sun,  9 Nov 2025 21:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1734F26E6F7;
	Sun,  9 Nov 2025 21:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="RRYA2cy+";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="f0fNuhbD"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B724469E
	for <linux-can@vger.kernel.org>; Sun,  9 Nov 2025 21:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762723912; cv=pass; b=Tay1KM2UvAXEoQore4Tz9YxApWxdXXjgkMPkuesj2dItUHKUZNpFHuzJGiy6jVkdgfdGR+hyY4VeONHmFoDmyvFyKNKK+XDgH3PRoEcMa7x56TWWwNuR68wOJzh9keHcETb+Mx3qXCWgWBGtzovftfqajy8kq0MWqK5w8EicKXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762723912; c=relaxed/simple;
	bh=B8IS2KSZQs7JMR419erGw7pT3os1yymzotwlokVvgqQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gSOkiDKVdtNMGzzpknVyOUYPz5PvvawEJfX2RCuzt00oi/wCiSsnq7YTtdgpOEz8azyr7vRsnIvwIWxU2Rxdx/I3MjPM2VBaJpAkBfwBnJCYi5SrwR0hgtb3DPWqE0h44oaX3DxuxWV4Wa3xCfzZ5pQcefqPzM/NLmIi7oYd1fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=RRYA2cy+; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=f0fNuhbD; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1762722459; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hBJPVRg8OQVa5PMyepSgfP5vT8faR1VU0AaER+UGkDO2sJHw4tjdI+NuuwqFdfrPBt
    ReW+JHVyahyB770LK0cA/3gQFVoKKoa94aXTAL+LP4Cd4lYfZhFWJs9qzy0OMZke+adH
    Gl0p7cZbURXSAyBzu4nddWWVIKoJ4UZcktHU/3q+wVoeeo13HD8MJa0rbagkFlk9SsM7
    k/xeL68u7xQcEIiw5H7mw7kkGlhpdQqJrjNdZfi1xOeoe+3C1t9JoczUMkE2Jh+8D+wN
    JYzIlzgRgJOB/ysVr50Lj6DkddFDJGGYou+plkaya3ymCLgKbSGOE8TR5ubIJtsgeQ1A
    yIjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1762722459;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=KiSHFumVedJDnGzcRoevZdHQMNt0cK/oQUH90xzyZKU=;
    b=ax2I3hbTRcNR6uETSL7OaEvpxagCswF5Cp3+5k0xnICuF6QgX02qgouVpr76LT3kBe
    CzTNgTmPIKTIZ5iGHtHueP3GHsERZFSUMPBMsTuDU43grDghb1sPQ0mcmOH+QA1+Aw75
    yxp0IwfBRliygVHdfrqZ2i+j65EhgILqWazu/qy42dGLTwxyF071rcn8i2R0SjB4ppKD
    jiPF3cemua3+cpCCbZJP7CUUa50FYErPPOIkJlorugtxLa7Wl5yjBkUGSGOWjY0Itkyi
    39chhDtq5OHYWRdvsT4J28H6dcpNjnmIB1e0YKX+BgwjVfSkBVyyKcHtwPZkj0+Qtf7H
    Nriw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1762722459;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=KiSHFumVedJDnGzcRoevZdHQMNt0cK/oQUH90xzyZKU=;
    b=RRYA2cy+zqT5Wjg9S2lNL9Hx0a7zChkR/eGS9aKwI7vBSbUiklRt2d+pxhXF1QVm2M
    CRvQGv9rG7xnyTWoGkHCI7mlIuatmWXStnbuNMsGnAQGEppf+ja5EBR48Lk5+1EzcF1t
    RPdyeaRa+QCyVwew6fE0pdLfKDDxwC5bXPsoPdvKl/vSPbmacyi4EKJDxzyGxr5od2zu
    TTTozELzchN8XPCk3SZqSYqkWdfErry43cFBpnbdVYV1nI/Qq+o4EMa137lZyfzFEPiX
    iUKzE1S0FvOG//07EQJkLBuM6ocU9zzzPmDuIXXJazUEzB9GK7EmFSXfYFmptCdEw746
    jqBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1762722459;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Subject:From:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=KiSHFumVedJDnGzcRoevZdHQMNt0cK/oQUH90xzyZKU=;
    b=f0fNuhbDp9f0o/TKrtRCL5NZ+ndLc1CZrkGXWraAOL9ktidLU+WquWmgNeyLTPouvZ
    3A6mFWxf6pq3bV1utHAw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461A9L7cFTE
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 9 Nov 2025 22:07:38 +0100 (CET)
Message-ID: <84cb473f-be5b-464b-a5d9-10c6f643f145@hartkopp.net>
Date: Sun, 9 Nov 2025 22:07:32 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vincent Mailhol <mailhol@kernel.org>, linux-can@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: RFC remove CAN_CTRLMODE_XL_ERR_SIGNAL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Vincent,

I've been playing with the PEAK CAN XL bitrate tool again and it gave me 
a new idea:

There were settings for different bitrates and the belonging/resulting 
flags for TMS and ES (error-signalling).

Staring at the options we have only three options for the CAN XL support 
aka "xl on":

1. Providing CC/FD/XL bitrates => ES on, TMS off (mixed-mode)

2. Providing only CC/XL bitrates => ES off, TMS off (CANXL-only)

3. Providing only CC/XL bitrates => ES off, TMS on (CANXL-only)

Therefore we only need "tms" as an additional option when xl is on.

The error signalling "on" automatically results from the availability of 
"fd on" and the FD bitrate.

Examples:

1. Providing CC/FD/XL bitrates => ES on, TMS off

ip link set can0 type can bitrate 500000 fd on dbitrate 2000000 xl on 
xbitrate 4000000

2. Providing only CC/XL bitrates => ES off, TMS off

ip link set can0 type can bitrate 500000 xl on xbitrate 4000000

3. Providing only CC/XL bitrates => ES off, TMS on

ip link set can0 type can bitrate 500000 xl on xbitrate 10000000 tms on

That's simple and provides only the needed switches, which makes 
CAN_CTRLMODE_XL_ERR_SIGNAL obsolete in the netlink API.

What do you think about this approach?

Best regards,
Oliver


