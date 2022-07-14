Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BAA575657
	for <lists+linux-can@lfdr.de>; Thu, 14 Jul 2022 22:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiGNU1Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 14 Jul 2022 16:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGNU1Y (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 14 Jul 2022 16:27:24 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DC927B36
        for <linux-can@vger.kernel.org>; Thu, 14 Jul 2022 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1657830441;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=U0m+wBXYdQEq8SbscMe32EkhQ6gENxCJlxzyM16BlwQ=;
    b=HXNmEuxzJiCP4vXVYqglDSoJg3Sb159iA8gfktNEKUlnYELd/pgcXKxZcJQ8fhnO1e
    QSSdWKPC1XxPHlR0Rqow+HqjRGncznow+IOS7iigRhWQ5VWeOSPTK/IK3ltkpAJd/h8G
    YCIHophkPa1x0iIuLlsN2nJKVnWwcmSY0izpZaAHjxhOFIEdM75rQcme8xhX/NUZAa58
    J19/9+egYa5I8do2ekq5g2pmR4TbpBD2Ay6H9+Ecvah1uobuz1k3zKC8rlyIeAI3GoFp
    5mKnOnuRb1qKb4aWj2cVL+XFWZXWBZsvvYsjaqYCkY7bUADyQenmthxX2jC28JgmW1Af
    Dm3g==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdIrpKytJSr63tDxrw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cfd:d100::b82]
    by smtp.strato.de (RZmta 47.47.0 AUTH)
    with ESMTPSA id t870d5y6EKRL6xY
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 14 Jul 2022 22:27:21 +0200 (CEST)
Message-ID: <c2cdf56c-a8a1-c7d4-f71b-afc917cdfeaa@hartkopp.net>
Date:   Thu, 14 Jul 2022 22:27:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 1/5] can: canxl: introduce CAN XL data structure
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org
References: <20220714160541.2071-1-socketcan@hartkopp.net>
 <20220714160541.2071-2-socketcan@hartkopp.net>
 <20220714193734.y7er5i7hsd7dqxie@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220714193734.y7er5i7hsd7dqxie@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org



On 14.07.22 21:37, Marc Kleine-Budde wrote:
> On 14.07.2022 18:05:37, Oliver Hartkopp wrote:
>> This patch adds defines for data structures and length information for
>> CAN XL (CAN with eXtended data Length) which can transfer up to 2048
>> byte insinde a single frame.
>>
>> Notable changes from CAN FD:
>>
>> - the 11 bit arbitration field is now named 'priority' instead of 'can_id'
>>    (there are no 29 bit identifiers nor RTR frames anymore)
>> - the data length needs a uint16 value to cover up to 2048 byte
>>    (the length element position is different to struct can[fd]_frame)
>> - new fields (SDT, AF) and a SEC bit have been introduced
>> - the virtual CAN interface identifier is not part if the CAN XL frame
>>    struct as this VCID value is stored in struct skbuff (analog to vlan id)
> 
> Where do we put the ADS bit (Arbitration Data Sequence Bit Rate
> Switching from Arbitration to Data Phase)?

ADS (arbitration to data sequence)

DAS (data to arbitration sequence)

These sections inside the CAN XL frame bitstream are used to switch the 
bitrate and the transceiver mode (when a switchable CAN XL transceiver 
is attached).

AFAICS there is no 'per frame' switching of the data bitrate as we know 
it from CAN FD.

The bitrate and transceiver settings are done once in the CAN controller 
setup.

Best,
Oliver
