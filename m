Return-Path: <linux-can+bounces-5100-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ED2BC36F8
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 08:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DCF5F34B76C
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 06:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA392246BA8;
	Wed,  8 Oct 2025 06:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csselectronics.com header.i=@csselectronics.com header.b="sKon2T+J";
	dkim=permerror (0-bit key) header.d=csselectronics.com header.i=@csselectronics.com header.b="LjPLCMpM"
X-Original-To: linux-can@vger.kernel.org
Received: from mailrelay-egress11.pub.mailoutpod3-cph3.one.com (mailrelay-egress11.pub.mailoutpod3-cph3.one.com [46.30.211.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280522EAB66
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759903732; cv=none; b=lBu+sXoOK5NKGn5ONF7+xf6aUS0NTF7xxRuFAuYRvoHXYSRGRzBOtUw2c67ha+KWkzFR0B/pkPJWC/j0tX/53Tuj4XUbXJsGi9b7Nk09LuFSUhiTwSCiuLeg/gKPW8WclGqfcS81AzcpayYorV4hQzduwGaSts2/6nqw6JFeLT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759903732; c=relaxed/simple;
	bh=YbephDjOIqzfhBImfDmW60sos+am3ahj74uo8VIfGn8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=hHE9AbdVPnLd0UCjfEgPE90CkcJCIOhuBIJCCsIrQpBu4NKmqzFmAaZsIYwZUm0zAlw3Yv7GFSyySbekgqrxsVZNMfIQ6RjZJXOqhZPxlNG6XQLZs4EFFCmMHWVs+9gQDq8mrEK+b03QP0Q6JNkRr+ejqdFUNXqLi4nNKaAuFqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=csselectronics.com; spf=pass smtp.mailfrom=csselectronics.com; dkim=pass (2048-bit key) header.d=csselectronics.com header.i=@csselectronics.com header.b=sKon2T+J; dkim=permerror (0-bit key) header.d=csselectronics.com header.i=@csselectronics.com header.b=LjPLCMpM; arc=none smtp.client-ip=46.30.211.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=csselectronics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csselectronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1759903725; x=1760508525;
	d=csselectronics.com; s=rsa1;
	h=content-transfer-encoding:content-type:to:subject:from:mime-version:date:
	 message-id:from;
	bh=teE+2wXzdFUYRVYWl2Mad54N3UcmKDxYfmCqQU4kzmE=;
	b=sKon2T+Jfi7awG9yVAsxIkFl6ZlcpTni5fca10jUtCEghNOPB3DkLaUl5QUieIi/vo5EM6ThsytPl
	 86a3pa35v2cGXdngloRXyHShsLrW1Xt1JNpCi71GLD0cTUgHZbNZYRpZNoyCUgrgbgfOpeaoOuknfs
	 5kWiGSrRTJyTzEdyHY6uEpmRDFZI+oqMeNFg3gWZKCHkVlF68Xxwgp19RkDGRq7wmyIdtvPRFKc507
	 tCKhIoPy3wYv8IGTz0Uvwubxk3zN0P/8ePEQfyMaCa+dbn9PCKF9NI6osynzwU6kl+8VwBs0pxVirz
	 7IbqJwHVdNRXKXAGPsWpa5QoPziaxzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1759903725; x=1760508525;
	d=csselectronics.com; s=ed1;
	h=content-transfer-encoding:content-type:to:subject:from:mime-version:date:
	 message-id:from;
	bh=teE+2wXzdFUYRVYWl2Mad54N3UcmKDxYfmCqQU4kzmE=;
	b=LjPLCMpMuHu38RePC46LVaOoTkg6t4VPpgMVnzr/M0dqBOVpGv2loO7AinNn7+iPQCWfQjT6lYEAX
	 HwEuY5aDw==
X-HalOne-ID: 3ea47e39-a40d-11f0-9076-d510462faafc
Received: from [192.168.1.152] (unknown [5.103.118.41])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 3ea47e39-a40d-11f0-9076-d510462faafc;
	Wed, 08 Oct 2025 06:08:45 +0000 (UTC)
Message-ID: <ef30ff2e-a283-4aa2-be7c-902acfced35e@csselectronics.com>
Date: Wed, 8 Oct 2025 08:08:43 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?Q?Magnus_Aagaard_S=C3=B8rensen?= <mas@csselectronics.com>
Subject: Exposing CAN hardware from userspace
To: linux-can@vger.kernel.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

I am attempting to interface with the CAN hardware in a remote device 
over a network and expose it locally as a SocketCAN bus. The remote 
device does not run Linux, but I am able to fully expose the CAN 
hardware over the network using a custom protocol. Latency in itself is 
not an issue for this use case, but accurate timestamping and reliable 
transmission to the remote is.

So far I have found a few userspace tools which could handle the network 
communication aspect (such as socketcand[1] and cannelloni[2]), but 
these all seem to expose the remote side as a local node on a SocketCAN 
bus and not a bus in itself.

As there is no CAN hardware locally in my use case, the only option is 
to create a virtual CAN bus via vcan if using the above userspace tools. 
This presents a few issues:
* The remote timestamp information is not propagated to the local 
SocketCAN bus. I.e. the accurate remote hardware timestamp is replaced 
by a local software timestamp.
* The direction of messages is lost, as all messages are sent into the 
vcan bus and thus marked as tx in e.g. candump.
* Flow control from the remote side is lost, such that local nodes can 
send CAN frames even though the remote side is fully loaded.

Overall, vcan is likely the wrong tool for this job, but I am not aware 
of any alternatives. Are there any options I have missed which can solve 
the above issues without providing a new kernel module? The use case 
seems closely related to the tun/tap driver in the networking stack in 
general, but I am unsure if these could be extended to handle the 
SocketCAN case.

If I were to take the route of a new kernel module, what options do I 
have for exposing the data and control structures of a SocketCAN bus to 
userspace? So far I know of file descriptors as in the tun/tap case, but 
I am not knowledgeable enough in the kernel systems in general to see if 
there are other options which would be a better fit for bidirectional 
data and/or asynchronous messages?

Any advice is appreciated.

Regards,
Magnus.

[1]: https://github.com/linux-can/socketcand
[2]: https://github.com/mguentner/cannelloni

