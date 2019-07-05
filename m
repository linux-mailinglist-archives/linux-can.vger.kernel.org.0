Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D091609DA
	for <lists+linux-can@lfdr.de>; Fri,  5 Jul 2019 17:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbfGEP6l (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 5 Jul 2019 11:58:41 -0400
Received: from mail.iot.bzh ([51.75.236.24]:62904 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbfGEP6l (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 5 Jul 2019 11:58:41 -0400
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jul 2019 11:58:40 EDT
Received: from [192.168.5.93] (153.79.119.80.rev.sfr.net [80.119.79.153])
        by mail.iot.bzh (Postfix) with ESMTPSA id 944DA40078
        for <linux-can@vger.kernel.org>; Fri,  5 Jul 2019 17:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1562341936; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=x+yFORbNjbxZZGXRUAyoSYf9IB7D3EBjEQqslhcEP5Y=;
        b=dp+aCbRQXEWcDk6Retl2E8gjlbPqYWpyB3jFIWiiEcRNlz4h/ZHUnuPUs3jtVrai4xbUGC
        Bs4rQqypX1c57cGOTnuJuxFpEQDCxJkXMn9wn906fGuTNeNxc7zIirHCmx6oBZ7WwKMA/w
        tKyDZT2x2kBHpplBjvUcktYOK9xrySsg8L5pHnabSRyGLY6FDndWHwPEhq2fAICwWjYTHr
        3jaQQqbQAQp7fk3VXQc+zEnwcgXzCjz6Sxbr1KrfMhlCDYNBWJmTob3HK1wUvo094YS2Xq
        YsNxqlcmxNtUnilz5zwRUmcZzv/MRvQuEzrXkEPkc3TxHNMV5EBz6Y1y+KTinA==
To:     linux-can@vger.kernel.org
From:   Arthur Guyader <arthur.guyader@iot.bzh>
Subject: J1939 : Address Claiming
Message-ID: <43c0a773-ec06-5288-9fcc-9cdf68e72879@iot.bzh>
Date:   Fri, 5 Jul 2019 17:52:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello all,

I looked at the code of can-utils and more precisely jacd.c.

In the way it is implemented, the deamon's only objective is to change 
its address according to the different requests it receives.
More precisely, the socket is blocked until the next received claiming 
address request (recvfrom).

In a real implementation, do you need two sockets?
     - one to receive and write messages
     - another dedicated only to the claiming address
Or did you have another solution?

In the documentation, it says: "If another ECU claims the address, the 
kernel will mark the NAME-SA expired", how can this be checked?

Do you plan to integrate the management of the claiming address (jacd.c) 
into the kernel or leave it to the user?

Thank you very much.

Best regards

--
Arthur Guyader - Embedded Engineer - IoT.bzh

