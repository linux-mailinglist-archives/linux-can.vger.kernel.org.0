Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41CA0658E3
	for <lists+linux-can@lfdr.de>; Thu, 11 Jul 2019 16:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfGKO3I (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 11 Jul 2019 10:29:08 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:33445 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfGKO3H (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 11 Jul 2019 10:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1562855345;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=6rGIpSCQIYnPyeMWYodPaGEuZjX7T7fleLgctsbvGPo=;
        b=b9NCLPrmuNOgG7Ie9QWQKp9syivMksbcvZ63+aN+oCXHpluQZnPxUgruDNsYqH6nc3
        heZuMbQnkq/QwYjldJsRl3gkWJG2A71yB5o0KHFLCVwZ6dFaskM/PI8JRCHqUfPzu9ri
        izOYEbw0cMLcgxfCmNEEqoAUkfzSzfyO/yTsAuYHEEkkupIIn/fU7wi3YptBr857qCO2
        vATbvKShmmu27TftdaN/s71KjkoZmoXJreRtBptdPNDJ0KlKxSBvZRxYGO5haezX21S/
        jNzYf9PpG2Ml1PL/pVRNLG0g84KPQ03mhpBotwA0xsRl4Qk8yQsl0QgyfrYLkffCi6aJ
        St8w==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJVsh7kSA="
X-RZG-CLASS-ID: mo00
Received: from [192.168.40.177]
        by smtp.strato.de (RZmta 44.24 DYNA|AUTH)
        with ESMTPSA id k05d3bv6BET47tO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 11 Jul 2019 16:29:04 +0200 (CEST)
Subject: Re: BCM on ethernet link
To:     laurent vaudoit <laurent.vaudoit@gmail.com>
Cc:     linux-can <linux-can@vger.kernel.org>
References: <CAA7hF3zC2SrgC6JaKWzTDE6L6bP2o=zM_ZwdXgU7hwfJMraiCA@mail.gmail.com>
 <03c043d3-94e8-1865-b427-cc2a401bbd39@hartkopp.net>
 <CAA7hF3wReDrLcu5TtthO7NoxqK=uqzM-y6BtZJDjUVrPRz6bHg@mail.gmail.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <1535589c-af2b-796d-b06a-88356be15e29@hartkopp.net>
Date:   Thu, 11 Jul 2019 16:28:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <CAA7hF3wReDrLcu5TtthO7NoxqK=uqzM-y6BtZJDjUVrPRz6bHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Laurent,

On 11/07/2019 10.49, laurent vaudoit wrote:

> Currently we use mainly TX periodical frames with update of frame when
> needed (when a data change in our application)
> and also RX stuffs, with rx timeout to be inform if a frame was not received.

The reason for cyclic messages in cars is to detect failures on the 
transmission side (frames missing) or cover failures and restarts of the 
receiver side - e.g. due to undervoltage which might hit different ECUs 
in different manners.

As RDS provides a reliable transport the only missing function is to 
handle these startup and recovery situations. E.g. when the data sink 
reboots the content has to be pushed again.

Regards,
Oliver
