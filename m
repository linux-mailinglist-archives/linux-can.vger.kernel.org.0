Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2B95BA5A4
	for <lists+linux-can@lfdr.de>; Fri, 16 Sep 2022 06:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiIPEPF (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 16 Sep 2022 00:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIPEPD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 16 Sep 2022 00:15:03 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B152715E
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 21:15:02 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id f14so32653047lfg.5
        for <linux-can@vger.kernel.org>; Thu, 15 Sep 2022 21:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=s+D2g1IMuJqRsGmASTGqUuEFCZBdAB1XobJl55Kbuuk=;
        b=LMy3C++NDxFCSu7R2/en1gIp+3aKimmjsLsyP6EaDz0dc7x6Y+bo6VAlrV8MJo70dI
         L4kNs6Xam9VoXtSkDC6LAc++ROSAjxXlcNxQeZRV7jiu+dnCO/l9vX13bfJQ2iIzzp1M
         W6B3VFUa20dW/kTaYSn+QH0PD98Gm8IBcViJ+q0Ny4qu65d8GNe2eZW9EmKMqxj5L1FE
         gfCFt8JIMX6kNtnJQreNSG6WUuiCLqcWJS1ITnyCqxOl7rGElfDcB6IhENNriwX49ans
         cm7YBE7RxYacdI5x0HzafrqxHOJhslFq2WzgU+E2PsPgSh+LxouguobzKza7Tjz/Vf+C
         dgkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s+D2g1IMuJqRsGmASTGqUuEFCZBdAB1XobJl55Kbuuk=;
        b=Be8wN9NqCVQ4QvYREEYyMcUwjv3jhs8hNiQytGgwfF4yX2mKKeELBIstZiooIhvkPm
         4afIEtE1ksQ9xah+YGnmota0Es3SE4GvveZ+Rk1sHcKpaNS70lwWwfiSUJ7rgjCP0C0S
         c2wq8Aij5ytlFr5ZFS+2B8sT0UnEqL2p6sgujqHnTsfP9wHsLlEhhlJm90DCPII4O7Sv
         HfXinFpai9DOCtLn27j5Vv0eYjIhhOjbzuQghWQqrzRDmkXX3rB3Cuov50nC1+iQyERR
         m+AyydP3iq0zbYUf/2lab94P+BtN0lnlXdhBOl8cjLQffL80csj7cun8YURdRaPQVogM
         ErzQ==
X-Gm-Message-State: ACrzQf1SP6dmHN48E9NII3QRYb8CFbljslW9Skga7tzNcXFFw/ZT114J
        NvJLhPq+ue7i2iauhJ7NMqM=
X-Google-Smtp-Source: AMsMyM7MxnS3F8a9aK1/F/tdelZ2TY9CMXvELmo71EHFsIovPSW5EjArj/Q6hRM7d0VlGD9BxYhaLA==
X-Received: by 2002:a05:6512:3989:b0:49f:480f:c9ae with SMTP id j9-20020a056512398900b0049f480fc9aemr957466lfu.343.1663301700469;
        Thu, 15 Sep 2022 21:15:00 -0700 (PDT)
Received: from [192.168.10.102] (89-253-118-72.customers.ownit.se. [89.253.118.72])
        by smtp.gmail.com with ESMTPSA id z17-20020a056512377100b0048b3a92a2dbsm3267022lft.215.2022.09.15.21.14.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 21:14:59 -0700 (PDT)
Message-ID: <8c481a4e-9493-25ae-f4d7-c12dc98bc83e@gmail.com>
Date:   Fri, 16 Sep 2022 06:14:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: CM-ITC, pch_can/c_can_pci, sendto() returning ENOBUFS
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     Oliver Hartkopp <socketcan@hartkopp.net>,
        linux-can@vger.kernel.org, wg@grandegger.com, dariobin@libero.it
References: <15a8084b-9617-2da1-6704-d7e39d60643b@gmail.com>
 <403e18fe-8695-cd56-38f3-0ffe3ec9e472@gmail.com>
 <36d0419b-297f-8e39-8843-051b55b8a2bb@gmail.com>
 <986401a8-5f5a-0705-82c4-4df339509e07@gmail.com>
 <556866e2-a3aa-9077-8db7-edc4ced69491@hartkopp.net>
 <f8a95bfb-b1c2-cd41-1106-ca739c438fb9@gmail.com>
 <df1d220e-bf99-1051-ca90-5bd52e6c64e7@hartkopp.net>
 <0eb1dd1b-427a-92c5-22ef-97c557cfec6e@gmail.com>
 <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
Content-Language: en-US
From:   Jacob Kroon <jacob.kroon@gmail.com>
In-Reply-To: <20220905155416.pgvseb6uggc67ua4@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Marc and Dario,

(CC:ing patch author Dario)

On 9/5/22 17:54, Marc Kleine-Budde wrote:
> On 01.09.2022 11:38:31, Jacob Kroon wrote:
>> I used "candump can0 -l" on the EG20T host to capture the traffic, and
>> then connected an CAN USB analyzer to the network and used that to
>> capture the traffic. One thing sticks out. This is the log from the
>> CAN USB analyzer:
> 
> Who generates these CAN messages?
> 

The invalid frames in the logs are being sent from the the EG20T host, 
but some of them have also originated from the other nodes in the network.

>>> ...
>>> 505.7052;RX;0x464;3;0x01;0x01;0x00;;;;;;
>>> 505.7052;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 505.7063;RX;0x65;64;;;;;;;;;
> 
> As Oliver pointed out, this doesn't look like a valid CAN frame. Is the
> analyzer and/or sender configured for CAN-FD?
> 

No, none of the nodes in the network are sending CAN-FD frames, they are 
all normal CAN frames, max 8 bytes.

>>> 505.7662;RX;0x440;3;0x32;0x20;0xFA;;;;;;
>>> 505.7912;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
>>> 505.9632;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 505.9632;RX;0x464;3;0x01;0x01;0x00;;;;;;
>>> 505.9752;RX;0x468;3;0x51;0x20;0xFA;;;;;;
>>> 506.0362;RX;0x440;3;0x32;0x20;0xFA;;;;;;
>>> 506.0622;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
>>> 506.2112;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 506.2112;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 506.2462;RX;0x468;3;0x51;0x20;0xFA;;;;;;
>>> 506.3072;RX;0x440;3;0x32;0x20;0xFA;;;;;;
>>> 506.3322;RX;0x44C;3;0x35;0x20;0xFA;;;;;;
>>> 506.4572;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 506.4580;RX;0x464;3;0x00;0x00;0x00;;;;;;
>>> 506.5162;RX;0x468;3;0x51;0x20;0xFA;;;;;;
>>> 522.7203;RX;0x1E;1;0xFF;;;;;;;;
>>> ...
>>
>> Note the third message from the top. This is what "candump" on the host
>> logs:
>>
>>> ...
>>> (1662022485.638794) can0 464#010100
>>> (1662022485.638940) can0 464#000000
>>> (1662022485.699405) can0 440#3220FA
>>> (1662022485.725166) can0 44C#3520FA
>>> (1662022485.896858) can0 464#000000
>>> (1662022485.897382) can0 464#010100
>>> (1662022485.909042) can0 468#5120FA
>>> (1662022485.970036) can0 440#3220FA
>>> (1662022485.995596) can0 44C#3520FA
>>> (1662022486.144685) can0 464#000000
>>> (1662022486.144768) can0 464#000000
>>> (1662022486.179595) can0 468#5120FA
>>> (1662022486.240561) can0 440#3220FA
>>> (1662022486.266274) can0 44C#3520FA
>>> (1662022486.391248) can0 464#000000
>>> (1662022486.391469) can0 464#000000
>>> (1662022486.450115) can0 468#5120FA
>>> (1662022502.662035) can0 01E#FF
>>> ...
>>
>> It fails to see the 3rd message from the previous log. What would that
>> indicate ? The CAN analyzer sees the message, but the EG20T doesn't.
> 
> Is this error somehow related to the "can0: can_put_echo_skb: BUG!
> echo_skb 0 is occupied"?
> 

Possibly.

What I do know is that if I revert commit:

"can: c_can: cache frames to operate as a true FIFO"
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=387da6bc7a826cc6d532b1c0002b7c7513238d5f

then everything looks good. I don't get any BUG messages, and the host 
has been running overnight without problems, so it seems to have fixed 
the network interface lockup as well.

Jacob
