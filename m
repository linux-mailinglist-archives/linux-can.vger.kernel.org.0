Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC1A2CD54B
	for <lists+linux-can@lfdr.de>; Thu,  3 Dec 2020 13:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387782AbgLCMRo (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 3 Dec 2020 07:17:44 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.24]:34629 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730351AbgLCMRo (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 3 Dec 2020 07:17:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606997629;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=3BGDa8TcfOs6122DftDQR0oBnzo9iblXLgqZNz3rQcc=;
        b=AbOtTglMRSaoLN1Q68E4P5Tvye6DOTPSvKz9lNR2lhEMdIxmQScDqKVfHZttuhTlYF
        l2EeoxwYY7GwDdz51c/lD3t6qjBVgWlc3kCwfYRJoLfiFzPujS3J7qlVc2GzLJCkOVml
        fZmrTSBAJs+1CV8l3NLQIaBg+/YKwEqoZHChD/jgl8YURpwdMtt6sWFUo4ZR+iBJdi2H
        4laLAykX5YopgljkCr/Xktv5fsn1AYglncTVIDyD2NK18Q9P3wZ/wHcHjNt5GT/KZYZU
        A82piDFDA54/QVDTEvlw1qWiCa6PUiJjsMBIz20P2mRTAxAW8sCwtl+jP+Ydb9/+ZNSy
        ZlhA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTEVR9J8hopw=="
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.65]
        by smtp.strato.de (RZmta 47.3.4 DYNA|AUTH)
        with ESMTPSA id n07f3bwB3CDlFFC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Thu, 3 Dec 2020 13:13:47 +0100 (CET)
Subject: Re: Suggestion to have a functional addressing/broadcast option for
 ISO-TP sockets
To:     Thomas Wagner <thomas.wagner@pa-systems.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>
Cc:     "thwa1@web.de" <thwa1@web.de>
References: <AM9PR06MB72834DE8FE187784AE914AB2B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <bf1b3dd2-1a43-0bc7-d1db-f4ad010944ed@hartkopp.net>
 <AM9PR06MB7283F123B4B9B5A781597379B5F30@AM9PR06MB7283.eurprd06.prod.outlook.com>
 <a01a36d2-725f-6de0-51bb-5a40be8d3e5b@hartkopp.net>
 <420f13ef-2993-7dd5-d537-085c1445be61@hartkopp.net>
 <AM9PR06MB7283E62151D53EF677B87517B5F20@AM9PR06MB7283.eurprd06.prod.outlook.com>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Message-ID: <06e4fc83-3297-53d9-e4a0-cb6b115faf96@hartkopp.net>
Date:   Thu, 3 Dec 2020 13:13:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <AM9PR06MB7283E62151D53EF677B87517B5F20@AM9PR06MB7283.eurprd06.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Thanks Thomas!

On 03.12.20 10:39, Thomas Wagner wrote:

>> I added a branch sf_broadcast to the repo:
>> https://github.com/hartkopp/can-isotp/commits/sf_broadcast
> 
> I pulled the branch and tested the flag by simply replacing my previous implementation
> that used the RAW sockets. Works wonderfully loaded into the Ubuntu 5.4.0-56 and
> a 2.6.31 custom kernel. I can ditch all the RX-path-settings and just use the flag without
> any errors. EINVAL gets triggered as expected for too long messages.  All default ISO-TP
> sockets stay unharmed. Wonderful, thanks for the quick solution!

I would like to add some Suggested-by: and Tested-by: tags to the patch 
if it's fine for you.

Which of your two email addresses would you like to see there?

Best,
Oliver
