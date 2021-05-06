Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC95F3759ED
	for <lists+linux-can@lfdr.de>; Thu,  6 May 2021 20:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236362AbhEFSCD (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 6 May 2021 14:02:03 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:21818 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236389AbhEFSCD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 6 May 2021 14:02:03 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1620324063; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=W+iVTO9HuJof1hEZTF/DeUPsjKU3C89n9YnXua5ocPX55BqnjqhJHQmI0Z/5nkwNAo
    IB6cEjA2ganLabsSVkBB5d0G8Uv0+NzX3RAHGwa0NvzUGymihRE78EPqiTY59h32Kujo
    yCvCeJ++jye0lYQKZU/zcXxZNPqGiDuCND+WAYxXU+B84SYx8aNlkNs2LbfyxaDshbW1
    cvXKX3zoVUoYjut2L/wEMrDR4+ixqj91BtngOjmvoqa5sArkhjo96Z385kjUt34Twssx
    K/h2AJ2Pnxhhbg/T21EO7SWeFsX5NLaWUgVlqcy1to+aubiVl3GzOWrsVvVC1dalq6nP
    /KQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1620324063;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Utbqd4mo9pMH66+lxQyVg812iLGjXms55qaqLiivWZI=;
    b=ooEzMRUf7kYeIJSek1Jzs2gEyD1CdXBoXRT1nXgTOGoNDFnUJfqJgM8GS0HfT569Q0
    TI+Ph6Bg8uSCAqX9gH6WdC6TRy6hzAL1aq/mIPnEfiidTaF6/7O1xbgapavKxEDmo5oG
    oqkN5tHVDR94Evly+uk/20J05pQw2EXxWZq5NeIGXgRdPovtOoPZWolT8S2SjJBwMIIe
    G8pQ5BTMe6//uiMHjq93UjQ5nPKiQkdZJcfiutGRQ59p4bqoQXzpFwnARNImXR1oai5/
    L0FnakLgWptxygFafnpCjJe8LDRk6O+eC5Bpg0tshc7fpzRHEoF9w5e7iRlgxjeW0i3F
    2hCg==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1620324063;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:Cc:Date:
    From:Subject:Sender;
    bh=Utbqd4mo9pMH66+lxQyVg812iLGjXms55qaqLiivWZI=;
    b=k8xQ0NMmKXsxBfeOcoMYPgYwK3BD+EVk4UfvHKL46OhFfEsgU8NxxDbCYtRCXCKEPW
    IZhA4qvbzrTO+NpGLsRvergcr6P0kbTzetuyR2Oa6xCWu1YZedcvZNqT8nxWk2kcu83P
    DJOXj3WS4ztOGBz75CUflQ6yj80iy0J4PJTwLLV9NKe/swnCjp4w6HUcZSp54LF3Ab2d
    dpzWee+yBN1VaN4xHiA+58oqSlNc6kZWARVwKqgCYXSQd9tejgJb0WRpjE4l+bdMdWIP
    HZC3T8w4WiZM+INjLH2KEayqvv34QefIaV6+TPtaa8I38TBOz8EpxhTh/jJDqyw+uV19
    5JKg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3HMbEWKONebStI="
X-RZG-CLASS-ID: mo00
Received: from [192.168.50.177]
    by smtp.strato.de (RZmta 47.25.6 DYNA|AUTH)
    with ESMTPSA id e040b6x46I1305Q
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 6 May 2021 20:01:03 +0200 (CEST)
Subject: Re: CAN ISO-TP
To:     Bartosz Zdanowicz <zdanowiczb@gmail.com>
References: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Message-ID: <a7df697c-b6d3-1894-dcc6-672698caa19a@hartkopp.net>
Date:   Thu, 6 May 2021 20:01:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAERdor5nY73X4qip=up8fNU=xT+H7r2XnKiob66=4DxovkBiGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

+CC Linux CAN ML

Hi Bartosz,

On 06.05.21 19:28, Bartosz Zdanowicz wrote:

> I'm not sure if you prefer e-mail message, but I don't want to raise 
> GitHub Issue yet.
> 

Raising a GitHub issue is generally a good idea as it may help other 
people too.

But asking on the Linux CAN mailing list is even better ;-)

> I'm using module that you are an author and it's working perfectly on my 
> local PC. I'm using Ubuntu with Kernel version 5.4.0-70-generic

Which branch did you use? master branch?

> I tried to simplify example where I use python wrappers and other things 
> and manage to get minimal example:
> 
> /import socket as s
> socket = s.socket(s.AF_CAN, s.SOCK_DGRAM, s.CAN_ISOTP)
> socket.bind(("vcan0", 1, 2))
> socket.send(b"AAAAAAAAA")
> socket.send(b"AAAAAAAAA")/
> /
> /
> It's working perfectly, even if I don't open receiver socket. It just 
> timeout and there is no issue.

But this should raise an issue as you send 9 bytes which would need 
segmentation.

This should only work with CAN FD frames with a single frame.

Can you create a candump log from vcan0 to see, what's going on the bus?

> I tried to run my application on RPI, when module is already included 
> with kernel version Linux raspberrypi 5.10.17-v7+ #1403 SMP Mon Feb 22 
> 11:29:51 GMT 2021 armv7l GNU/Linux.
> 
> I run above code and first send is working (no receiver as well), 
> timeout, but second one is printing
> 
> OSError: [Errno 70] Communication error on send

That's interesting! We are currently working on creating that kind of 
feedback.

https://lore.kernel.org/linux-can/97e2ddd5-cc8b-9c7b-6198-2eceee39dfd4@hartkopp.net/

So how is Python getting this information?

Regards,
Oliver

> 
> And pattern is repeated. So sending next data works and after those 
> error appears. It seems like sending new data somehow ,,validate" 
> previous send. When I create other socket that reads data it's working 
> perfectly. The issue is, somehow in our architecture other device might 
> be unavailable.
> 
> I checked also dmesg and there is no tips. Is it any known issue, or 
> maybe it's expected?
> 
> Thanks in advance for you reply.
> 
> Best Regards,
> Bartosz Zdanowicz
