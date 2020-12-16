Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A87C72DBA2B
	for <lists+linux-can@lfdr.de>; Wed, 16 Dec 2020 05:41:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgLPElB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 15 Dec 2020 23:41:01 -0500
Received: from smtp.cubyte.cloud ([62.113.199.100]:32049 "EHLO
        smtp.cubyte.cloud" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbgLPEkz (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 15 Dec 2020 23:40:55 -0500
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Dec 2020 23:40:54 EST
Received: from [192.168.1.10] (204-167-142-46.pool.kielnet.net [46.142.167.204])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp.cubyte.cloud (Postfix) with ESMTPSA id B71EB444BC
        for <linux-can@vger.kernel.org>; Wed, 16 Dec 2020 04:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=schich.tel; s=mail;
        t=1608093191;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Tu/tIA9bplO9pprYk0dStEuFVl74zLjditAWRuzbojQ=;
        b=I2ABg1qrFEYf5ILrG/piimq94ioie+PNQUxI13oOddmle8sbhTUPxePwkpk1aeJptIi6aT
        OSw7Soh4bPwYRQmZrqhClTzhQBt7ZNjISf3+t3GVPMBeYHff0IIDLJndnraabLyiKyg5ay
        KMSAsrY4AW0e4ebJVZ+loV8jd5k/ZLiXSIt0JLC3OQTMGpBc3jyN7HoL6avEQHP0Z/ae8N
        Vhv5GwKP1hl66RhLMKDOrfyBvbJYM2pZvCBVYeUsCvVSAytwgyqZrOiGcVGAN9kri7Wsdl
        i/T81UoDBdWbm6SHay2ipTErY30GmbxQwJn0yk+6tdjpp+5w5s1IrM704gKL0A==
Message-ID: <ac75d44f61007ece402aca50f49ee57138000d27.camel@schich.tel>
Subject: get entire CAN_RAW_FILTER value without knowing its size
From:   Phillip Schichtel <phillip@schich.tel>
To:     linux-can@vger.kernel.org
Date:   Wed, 16 Dec 2020 05:33:10 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi everyone!

This is my first post to this mailing list (or any kernel mailing
list), so please tell me if this is the wrong place for this kind of
topic.

I'm developing a Java binding library to SocketCAN using JNI [1], where
I try to provide a reasonably "Java-like" yet efficient and safe API.

Part of this are setters and getters for the SOL_CAN_* socket options,
which is straight forward for all options except CAN_RAW_FILTER, since
it is the only option with a dynamically sized value (struct
can_filter*). Setting the value is simple, since all the information is
available in user space, but when using getsockopt I'm expected to
provide a buffer and a size, but I don't know how many filters there
are without keeping that state in the library or application, risking
it going out of sync with the kernel. Is this correct thus far or am I
missing something? Relevant source on the kernel side is at [2].

On the user space side using getsockopt() I see three ways around this
issue:

1. Track the amount of filters in user space. I feel like this might be
problematic if e.g. sockets get shared between threads and processes.
Other bindings usually take this approach as far as I could tell, if
they support getting filters at all.

2. Allocate a buffer large enough that the filters will most likely all
fit, the optlen will be corrected to the actual size. This is the
approach I currently take (see [3]), but it feels very wrong.

3. Search for the right size by trying increasingly larger buffers
until the buffer is big enough to fit all. This would be kind of an
improvement to 2. for the common case.

Neither of these feel good to me, but maybe that is just me? On the
kernel side ([2]), I could imagine the option taking a void** for
optval and the kernel allocating a new buffer for the caller and
writing its address to the given pointer and the real length to optlen,
kind of like this (without knowing the appropriate functions):


case CAN_RAW_FILTER:
	lock_sock(sk);
	void* filters = NULL;
	if (ro->count > 0) {
		int fsize = ro->count * sizeof(struct can_filter);
		filters = allocate_to_user(fsize);
                if (!optval)
			err = -EFAULT;
		if (copy_to_user(optval, ro->filter, fsize))
			err = -EFAULT;
	} else {
		len = 0;
	}
	release_sock(sk);


	if (!err)
		err = put_user(len, optlen);
	if (!err)
		err = put_user(filters, optval);
	return err;

The setsockopt implementation of the option could also be adapted to
take the same void**.

Alternatively the implementation could always write back the full size
to optlen instead of the "written size" (put_user(fsize, optlen)
instead of put_user(len, optlen) in code). Since the caller knows how
big its buffer is, the size necessary would be the more valuable
information.

Did I completely misunderstand something or is this really a limitation
of the current implementation of this option? And if the latter is
true, are we in the position to change anything about this without
breaking user space?

I also haven't really looked into how other protocols handle
dynamically sized option values or if that is even a thing else where.

Either way, any feedback on this is very much appreciated!

~ Phillip Schichtel

[1]: https://github.com/pschichtel/JavaCAN
[2]:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/net/can/raw.c?h=v5.10#n663

[3]:
https://github.com/pschichtel/JavaCAN/blob/ab64fb416996978fc154f84c204bf25273ab1776/core/src/main/c/javacan_socketcan.c#L176-L182

