Return-Path: <linux-can+bounces-5452-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E68C61BE9
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 20:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E77713580CC
	for <lists+linux-can@lfdr.de>; Sun, 16 Nov 2025 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EC22417D1;
	Sun, 16 Nov 2025 19:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ac+PgtbO";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="EcCZzk7P"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [81.169.146.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F7920311
	for <linux-can@vger.kernel.org>; Sun, 16 Nov 2025 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.219
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763322153; cv=pass; b=hOWPgUygJuqcO5pWVUVEelyRmXN6e8j7iluUE+GX/U3gRT8P1sirO1Zj8nH+LAIPmX/xJ7bf2GAC8AUsMVBwdt22sxApXWlyeNsCSSwqDc4jp60FjHezVCaB77TbqCBY1nz0zR4sTaePDAiJoNzJmnlvqwt8AVKlK5qojkoh/kQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763322153; c=relaxed/simple;
	bh=qEx0051ZCKTiaWucNopL/MV0ypBlhW/Z0BtiZT+D5rE=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=UPuKXqbqoNXFSH/8hZNjYUdz5tZ/Tyv8rbiTTOoIudd2uUkbOgY05eXEkcfMKZutxhwIB51HhaWWlOQPo4lt/Hs5AaRfkDymCGbVfJhp5v4cAuynyqPj1wHgAwnTAWtDxG3FSTqfeJ7gM9+lUv9XWLMyqwt5M0HbNV+HmpOuNe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ac+PgtbO; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=EcCZzk7P; arc=pass smtp.client-ip=81.169.146.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1763322143; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=q9N4yCZ6+YZRrD2GtNmpSqp0LetzGi2sDQa272ZZYwBtE3Em9byTaZ1smIdMTnfFl7
    lTZSyhzF1d1AnjSoYMAvltkNSlckK5NLkfIA4pCedQaqfONLBWzzqDu4WQKhla2QZTBH
    kD8XoBIygtbBb2BpxUbBbjng7IhQ+gRcMtu1tQUIn0ac2q6rp9A86UGLLKrXq580wMef
    KIOJim7bdemRX7yNY22023e+Q28Z+Yjb4v5ZmnRQXbWQUyqFE3gxzBEESyKUG9CED/hC
    gdfcu/rOKOhuH8EyeYVWtWebdHM8d+t6RJcUpeVMK4Nny903S877glW++UbVeIJQRyEE
    BIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1763322143;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=gIGnioEesQHJb1+UuciPAT8cAy7p4nrd8zzwilSHe34=;
    b=pVuyvhStiG9sjCiodTFQa9GFSc3mCTVSr6w9mxD/hrVHYiDHJqLDGbevB3cBqh1QV1
    Fn673PT9sSEGM4Ty/Y1iDhzryJIWcwZSb7dGwb7Uo1N67c6cpZs/dm5PhETLgek9CJZu
    YfSaV0bSIHADdkOaxjBmujEoOXug7nE0F+pUNOCMDrXZz7Ex2AEFPir2WpA2VH5rFX4T
    66seAnCekEg4lLq7hnYmrVOslRjw1vabYuakAgTGw2kMTZyDsl0QeKw43n0YCW6IaWP8
    YXEf89XOyInj1DreE58OQvGspmz9os+AhUXmHL93fEEj1YiluZYTkMjBgzq9ukvAwCzk
    Jc+w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1763322143;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=gIGnioEesQHJb1+UuciPAT8cAy7p4nrd8zzwilSHe34=;
    b=ac+PgtbO0PhK0V5p2rCJhhuXTrbykvWjkt/AsNEdFsM/jJQ75Lky044p/6gzz/evrC
    u9zM/lDoel6JlF78dOrVceulvd9bj4tgVDp29oRCAF0ab2Aw1LJT0nBKpim/FnVW+Rwd
    GB/N4NDlfnqF5KVoZjn0rJapjzYDcVvCI8pAV7W4ENaVOCs9ItUx6D2qgLrmsayUawWO
    8a5H7IcIcsTtdIWg2oaVrSiRFPz7CI236thXF1DmmOo9zQOnz249R0AXhBajb+blU/Yu
    5GBu3yPqq5qrt/UDmUecrcqUVSnQ3Pd600WJMbEMkndPcpBg0YZztbZG3CqtS/Ajwupa
    ESmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1763322143;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=gIGnioEesQHJb1+UuciPAT8cAy7p4nrd8zzwilSHe34=;
    b=EcCZzk7PCdJG+lHmEU97V7GOHR+NFzed/w2MQ+zDqPM8K/m+lJ503ADIzF3Jrcdw8f
    AQZhneTL8gpDKRX2PxDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeEQ7s8bGWj0Q=="
Received: from [IPV6:2a00:6020:4a38:6810::9f3]
    by smtp.strato.de (RZmta 54.0.0 AUTH)
    with ESMTPSA id Ke2b461AGJgMhMR
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Sun, 16 Nov 2025 20:42:22 +0100 (CET)
Message-ID: <49120f0f-d05d-471c-8e9a-fbce75161e4e@hartkopp.net>
Date: Sun, 16 Nov 2025 20:42:22 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Vincent Mailhol <mailhol@kernel.org>,
 Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org
From: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: ip command using uninitialized flags?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi all,

switching from mixed-mode (FD/XL) to CANXL-only with TMS on the FD flag 
seems to survive:

Here FD is set to on:

root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 dbitrate 
2000000 fd on xbitrate 4000000 xl on tms on
Error: TMS and fd are mutually exclusive.

And here FD is not set but still seems to be active:

root@de1soc1:~# ./ip link set can0 type can bitrate 1000000 xbitrate 
4000000 xl on tms on
Warning: TMS can not be activated while CAN FD is on.

Is this a common pattern not to modify flags that are not explicitly 
defined?

Or should the flags be zero-initialized with the defaults (0 = off) ??

Best regards,
Oliver

ps. IMO the "Warning: TMS can not be activated while CAN FD is on." 
should be an "Error: TMS ..."


