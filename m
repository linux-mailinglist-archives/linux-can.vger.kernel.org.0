Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E887334E1
	for <lists+linux-can@lfdr.de>; Mon,  3 Jun 2019 18:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbfFCQZK (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 3 Jun 2019 12:25:10 -0400
Received: from mail.iot.bzh ([51.75.236.24]:34056 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728311AbfFCQZK (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Mon, 3 Jun 2019 12:25:10 -0400
Received: from [10.18.0.57] (unknown [10.18.0.57])
        by mail.iot.bzh (Postfix) with ESMTPSA id D4A5340054;
        Mon,  3 Jun 2019 18:25:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1559579103; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=Es3U+56yYu/Oh0fSjUyIA9Lp7cno78ubCzl1ajFc+iI=;
        b=VQ7fZsddlpmmfCsJTS1RHX3LeGYP2KVrR0xIp6o6iGPqaDSZ974Rxt1ETxvh4i2ANHFAlt
        0WYjlaMf/ACI4ySAYVh6LfeS1tVYPC+W4bphvYnnr84lTGKRUYOI0CS7vZRKCCuunBxXQT
        DLTz6CeQOBJfYnxofXdnAdvYcNrD+5HtyRosRQ2W8NAbnuvd8/qv8nMmn73Xw+fUfet5S8
        BQOu8ts92Xcll/zoM4dPZCi4Iv+OZMy3Kz9EWgipvQDzaqG8LzF9AWPbkVpcvxKLb83k2/
        kd7F1YLYxuwokLL64ZroOv1VjGxOvJ5jeteHefAf5o1BMWfnGcEyNRDJUQwbUA==
To:     linux-can@vger.kernel.org
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Subject: J1939 in AGL
Organization: IOTBZH
Message-ID: <ede28202-7be2-5a2f-bc17-4f3af02471bf@iot.bzh>
Date:   Mon, 3 Jun 2019 18:25:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi,

We are working to support the J1939 protocol, using your works on 
socketCAN, in AGL (Automotive Grade Linux). We are facing some problems 
or questions about how to use it. We still have support for LTSI Kernel 
which is 4.14 by now and certainly will be 4.19 for the next and your 
work are based on the latest Linux v5.1 version.

Backporting them to 4.19 seems easy, we just took the diff at the head 
of the "j1939" branch of linux-can-next repository as patches and 
applied them to the mainline 4.19 Kernel. We did the same about the 4.14 
but only took the J1939 relative patches with a slight change on 
drivers/net/can/dev.c patches in the patches implementing the CAN 
midlayer private.

Is it planned to support the 4.19 version in the future as it seems to 
be the next LTSI version ? And less probable, do you planned for 4.14 
the actual LTSI ?

What do you think about the way we did to backport the work on J1939 ? 
Runtime tests aren't been ran for now but we just prove that patches 
apply, which is not enough for sure, but as the work are limited to the 
J1939 module then we are relatively confident and would appreciate your 
feedback.

Best regards

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

