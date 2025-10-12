Return-Path: <linux-can+bounces-5139-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FE6BD06A4
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 18:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 84F104E1E12
	for <lists+linux-can@lfdr.de>; Sun, 12 Oct 2025 16:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A36F61DF963;
	Sun, 12 Oct 2025 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lgo26uS2"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF4C1EA65;
	Sun, 12 Oct 2025 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284879; cv=none; b=iYNbRwf29iwhyX5LbQmxoKZOGkvw0q9KFKG2VZoufU/PSrTOmPq0aglN7LGuaxBRevRGxhyHIcYd1ciOoO+NfDRZ2pIeIGWdk2UyNxrsNMcoS1Iu2K3TXCMlXdZMUekqjZ2I7Y2bmE7jgzuaCgxzDRprcrIuYQBzK1TbjtPu+Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284879; c=relaxed/simple;
	bh=nuCpDcaIg+ludZm6wKQk4NOIO06DFnB9ROm6alQpbkg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLoVbIYSm8waApgGqamFJAgBJpMk2rs8NoQrbE1TCk5uPwo2lmWKnKefGIxhMpIuWFlRsAXtp1PBYNdoI9Ie/mlESrCgIvX/Ld7k+nqZZKPEifhTJBAN6bFFdySyb56GqW3MlTWo49zyqwH41u9gXdqKLVNMcwLhNCLPTFyGD/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lgo26uS2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDA35C4CEE7;
	Sun, 12 Oct 2025 16:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760284878;
	bh=nuCpDcaIg+ludZm6wKQk4NOIO06DFnB9ROm6alQpbkg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lgo26uS2OIp5tlRd2gFqM1yZDIIxfNYLOgglamjrOaj9Elz/84HuwTHlMIKqoGGbw
	 sZF4x5q5YLX/pKgWCv9Oivzyx4ymSx/ldPdGfLAYKM/Sz6APrnsTAoierUty+NH9vF
	 FxgJs/LdzMoC1JOLZITF4diky8XVbBcfY6rMwYX5bj+xY76i3ChXz9wQ4uMt+3On8I
	 VsPVE6f6l78X8aDi6Cm4waVTtbaQPmzze+BL4uICztHkgY7zy6VdwWHSwbXw6oAt+f
	 X+DumqVuuP9Qfahjf9m/azFc6qj7eGjOZIzv3cZTOPQ+uiPxLZPk2V81AiR65Fgbse
	 ykCOAbQIWOH5w==
Message-ID: <0c6045c9-67e1-4358-ae3a-d63c343eef79@kernel.org>
Date: Mon, 13 Oct 2025 01:01:15 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] can: add Transmitter Delay Compensation (TDC)
 documentation
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oliver Hartkopp <socketcan@hartkopp.net>,
 Marc Kleine-Budde <mkl@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-can@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251012-can-fd-doc-v1-0-86cc7d130026@kernel.org>
 <20251012-can-fd-doc-v1-2-86cc7d130026@kernel.org>
 <1b53ea33-1c57-40e9-bc55-619d691e4c32@lunn.ch>
Content-Language: en-US
From: Vincent Mailhol <mailhol@kernel.org>
Autocrypt: addr=mailhol@kernel.org; keydata=
 xjMEZluomRYJKwYBBAHaRw8BAQdAf+/PnQvy9LCWNSJLbhc+AOUsR2cNVonvxhDk/KcW7FvN
 JFZpbmNlbnQgTWFpbGhvbCA8bWFpbGhvbEBrZXJuZWwub3JnPsKZBBMWCgBBFiEE7Y9wBXTm
 fyDldOjiq1/riG27mcIFAmdfB/kCGwMFCQp/CJcFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcC
 F4AACgkQq1/riG27mcKBHgEAygbvORJOfMHGlq5lQhZkDnaUXbpZhxirxkAHwTypHr4A/joI
 2wLjgTCm5I2Z3zB8hqJu+OeFPXZFWGTuk0e2wT4JzjgEZx4y8xIKKwYBBAGXVQEFAQEHQJrb
 YZzu0JG5w8gxE6EtQe6LmxKMqP6EyR33sA+BR9pLAwEIB8J+BBgWCgAmFiEE7Y9wBXTmfyDl
 dOjiq1/riG27mcIFAmceMvMCGwwFCQPCZwAACgkQq1/riG27mcJU7QEA+LmpFhfQ1aij/L8V
 zsZwr/S44HCzcz5+jkxnVVQ5LZ4BANOCpYEY+CYrld5XZvM8h2EntNnzxHHuhjfDOQ3MAkEK
In-Reply-To: <1b53ea33-1c57-40e9-bc55-619d691e4c32@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 12/10/2025 at 23:47, Andrew Lunn wrote:
> On Sun, Oct 12, 2025 at 08:23:43PM +0900, Vincent Mailhol wrote:
>> Back in 2021, support for CAN TDC was added to the kernel in series [1]
>> and in iproute2 in series [2]. However, the documentation was never
>> updated.
> 
> Hi Vincent
> 
> I also don't see anything in man ip-link, nor ip link help. Maybe you
> can add this documentation as well?

The help is indeed not directly visible. But I think this is intended
because can is a sub type. The can is simply listed in man ip-link
under the Link types enumeration.

The can help then be obtain by providing that can type:

  $ ip link help can
  Usage: ip link set DEVICE type can
  	[ bitrate BITRATE [ sample-point SAMPLE-POINT] ] |
  	[ tq TQ prop-seg PROP_SEG phase-seg1 PHASE-SEG1
   	  phase-seg2 PHASE-SEG2 [ sjw SJW ] ]

  	[ dbitrate BITRATE [ dsample-point SAMPLE-POINT] ] |
  	[ dtq TQ dprop-seg PROP_SEG dphase-seg1 PHASE-SEG1
   	  dphase-seg2 PHASE-SEG2 [ dsjw SJW ] ]
  	[ tdcv TDCV tdco TDCO tdcf TDCF ]

  	[ loopback { on | off } ]
  	[ listen-only { on | off } ]
  	[ triple-sampling { on | off } ]
  	[ one-shot { on | off } ]
  	[ berr-reporting { on | off } ]
  	[ fd { on | off } ]
  	[ fd-non-iso { on | off } ]
  	[ presume-ack { on | off } ]
  	[ cc-len8-dlc { on | off } ]
  	[ tdc-mode { auto | manual | off } ]

  	[ restart-ms TIME-MS ]
  	[ restart ]

  	[ termination { 0..65535 } ]

  	Where: BITRATE	:= { NUMBER in bps }
  		  SAMPLE-POINT	:= { 0.000..0.999 }
  		  TQ		:= { NUMBER in ns }
  		  PROP-SEG	:= { NUMBER in tq }
  		  PHASE-SEG1	:= { NUMBER in tq }
  		  PHASE-SEG2	:= { NUMBER in tq }
  		  SJW		:= { NUMBER in tq }
  		  TDCV		:= { NUMBER in tc }
  		  TDCO		:= { NUMBER in tc }
  		  TDCF		:= { NUMBER in tc }
  		  RESTART-MS	:= { 0 | NUMBER in ms }

Does this make sense?


Yours sincerely,
Vincent Mailhol


