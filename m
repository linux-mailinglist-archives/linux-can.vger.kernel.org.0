Return-Path: <linux-can+bounces-2672-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C79C5A17ED2
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 14:30:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 632C81886D1B
	for <lists+linux-can@lfdr.de>; Tue, 21 Jan 2025 13:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C741F2377;
	Tue, 21 Jan 2025 13:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="ScsvM9Ls";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="zuXx3fRO"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB351F2394
	for <linux-can@vger.kernel.org>; Tue, 21 Jan 2025 13:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737466199; cv=pass; b=d+htX43HD/gQYzTcT/Uizk5W5zXk7nUqcFF2EZaH2kQ+dCIca0KDL34CcqObQ46OUe8rlrb3VgV6ppssPxF0OXvGyRPzG4Gwnovo33+fMiU7YhTs+6yNvjMgQ0aeSG7Kn4mPxSIDD0wISHzGbiqIrxKXqxn0kJZ00aK4g8m5gYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737466199; c=relaxed/simple;
	bh=U7f9WkFaKftgD5BLH9UEzwKyWducoI21eYCTEtFViiI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CX135jfMA2DKMbTPkbIKgC+kOIVPVQ4AyWLJzr6mLvK2RclYUsUkdnGg8CDTis8IvVuns6FFE/CHac0kxmyD6hSwDD4cx9mILsduOr8w50TASWmeyQ+o2NAIwrSYXKaM92uVqyYs1tmdXgX/e//wGmVI7Fx2wfCR5fCrbG6mHFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=pass smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=ScsvM9Ls; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=zuXx3fRO; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1737464395; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NzAZUOlZEeOQx6yTkFAb1cRRDhCYmklXhM+OmGFs0e7VocfteriNiQqOQmXF7Sfxqp
    TiObhFA/s7dtKswtrfDzsCg0rfnG25b6hI9i5s8ZMm0Ls++LZ9mzj/ZPIpTC/f51Pv7j
    dr4ZfnW2hg7SGWKDEvqd06el8E19Bfmb0/eJs+/QU47IO6L+BzcjtGAYnieVnTP7hwI1
    a3uNruQefJw9jDuYOigipN+vlQVyW4wvzSpi8MRk//DuwiB9ebqRguESRjtngLlf1yf3
    Qlr33g8tNUP894Ft2j9KOf3J8OtIAcn7s7viprVpTrVIeB51aaU9VyplEvFViPOg1UW4
    hciQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1737464395;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=zyaTWPom8lthyY1NX3fycj41ZkeQVu233sNCHhuTtQ4=;
    b=IqFVh3rXDXKQexSrOgRl6k25+SoBUIzUZilEN4502LnJxmDWHwN104ElSyEFGgQsO7
    683sqc+6Ex6oai41PWtkghc0TL9Wxnu8t23BoDAYKN0hw3Caezquuho9I+H/slDsySdS
    Ill6vA+Rz0tZJ1IEKgqzRbwRTSrOgaCyTv5HsCOFblx9GCNiNBeAIliOnFLTTQLamSrT
    i+jWO3ERb97g9gL3sRQ2bwTw52pbX3Hyqv2mfK7GVaglkoGMK8OzrmhV39B00Upwc6AI
    jKgwc2HSwY8vsuLQw17uzr2GQT6XvOmAqfmVkGpnDNjV8npIopEFQSbnrke1UTA4bqDk
    i1rw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1737464395;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=zyaTWPom8lthyY1NX3fycj41ZkeQVu233sNCHhuTtQ4=;
    b=ScsvM9LsVTuMwgFfb2ReTJt40o/VQg0mYsr8UnvoOg52EoEI+BKyQsKgEmJQeljlQp
    D7bEch8DtuJlEB7CYqQnPqzWwOUl3kIjBOJ2utOIYbECIXm9S2vPTUQcIHIO328+l0S9
    iCHv85IDkC9A9hHUxXMLBeDFY7j8GhdfHliJECfOA0RgNe5IG4H9EbePVEJLJcZ2b2Ja
    DiEs/RIVdhZ1clj5Gftd3LlWKJt4TklVA2nxOvCR9a5yMpHlip7UQPrpQyW9QEBnDj4s
    Wzw0lbsmTJY9dZmSY3m8fFxjcSFfn/k6HNea4GrjP4wxjbEOl1mE0KwVUgQfgv7wQNQ+
    nzng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1737464395;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:To:Subject:Date:Message-ID:Cc:Date:From:
    Subject:Sender;
    bh=zyaTWPom8lthyY1NX3fycj41ZkeQVu233sNCHhuTtQ4=;
    b=zuXx3fROQwH21e4SZwjgxiM4H00MZ2keiSW+VytC5VvANeGMzhYZ1LCsZoDVMQ5y00
    8tyJkMybLxMPqmVgOHDQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/vMMcFB+4xtv9aJ67XA=="
Received: from [IPV6:2a00:6020:4a8e:5010::9f3]
    by smtp.strato.de (RZmta 51.2.21 AUTH)
    with ESMTPSA id Ka08e410LCxsPME
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Tue, 21 Jan 2025 13:59:54 +0100 (CET)
Message-ID: <73bd2d13-6f30-4fbb-8842-77dea6231a33@hartkopp.net>
Date: Tue, 21 Jan 2025 13:59:50 +0100
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: canbusload and canfd
To: Sven Schuchmann <schuchmann@schleissheimer.de>,
 linux-can Mailing List <linux-can@vger.kernel.org>
References: <BEZP281MB2245032053822A5B4303317AD9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <BEZP281MB2245032053822A5B4303317AD9E62@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sven!

On 21.01.25 13:14, Sven Schuchmann wrote:
> Hi,
> I am trying to use the canbusload utility for the first time - ashes on my head :-)
> 
> I have an canfd interface configured like this with some traffic:
> $ ip -det a s canfd0
> 3: canfd0: <NOARP,UP,LOWER_UP,ECHO> mtu 72 qdisc pfifo_fast state UP group default qlen 4096
>      link/can  promiscuity 0  allmulti 0 minmtu 0 maxmtu 0
>      can <BERR-REPORTING,FD> state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 500
>            bitrate 500000 sample-point 0.800
>            tq 25 prop-seg 31 phase-seg1 32 phase-seg2 16 sjw 3 brp 1
>            mcp251xfd: tseg1 2..256 tseg2 1..128 sjw 1..128 brp 1..256 brp_inc 1
>            dbitrate 2000000 dsample-point 0.700
>            dtq 25 dprop-seg 6 dphase-seg1 7 dphase-seg2 6 dsjw 4 dbrp 1
>            mcp251xfd: dtseg1 1..32 dtseg2 1..16 dsjw 1..16 dbrp 1..256 dbrp_inc 1
>            clock 40000000 numtxqueues 1 numrxqueues 1 gso_max_size 65536 gso_max_segs 65535 tso_max_size 65536 tso_max_segs 65535 gro_max_size 65536 parentbus spi parentdev spi0.0
> 
> If I do "canbusload canfd0@500000" the output is nothing.
> If I do "canbusload canfd0@500000 -r" the output is "canfd0@500000     0       0      0   0%"
> 
> Do I need to give a special bitrate for canfd to work?

Yes, of course!
Without the data bitrate it is hard to measure the CAN FD busload ;-)

Try

canbusload -?

or just without any options to get the help text:

$ canbusload -?
canbusload - monitor CAN bus load.

Usage: canbusload [options] <CAN interface>+
   (use CTRL-C to terminate canbusload)

Options:
          -t  (show current time on the first line)
          -c  (colorize lines)
          -b  (show bargraph in 5% resolution)
          -r  (redraw the terminal - similar to top)
          -i  (ignore bitstuffing in bandwidth calculation)
          -e  (exact calculation of stuffed bits)

Up to 16 CAN interfaces with mandatory bitrate can be specified on the
commandline in the form: <ifname>@<bitrate>[,<dbitrate>]

The bitrate is mandatory as it is needed to know the CAN bus bitrate to
calculate the bus load percentage based on the received CAN frames.
Due to the bitstuffing estimation the calculated busload may exceed 100%.
For each given interface the data is presented in one line which contains:

(interface) (received CAN frames) (used bits total) (used bits for payload)

Examples:

user$> canbusload can0@100000 can1@500000 can2@500000 can3@500000 -r -t 
-b -c

canbusload 2014-02-01 21:13:16 (worst case bitstuffing)
  can0@100000   805   74491  36656  74% |XXXXXXXXXXXXXX......|
  can1@500000   796   75140  37728  15% |XXX.................|
  can2@500000     0       0      0   0% |....................|
  can3@500000    47    4633   2424   0% |....................|


So it is e.g.
canbusload canfd0@500000,2000000

Best regards,
Oliver


