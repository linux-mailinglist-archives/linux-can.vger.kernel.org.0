Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F07C9B19C9
	for <lists+linux-can@lfdr.de>; Fri, 13 Sep 2019 10:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfIMIo3 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 13 Sep 2019 04:44:29 -0400
Received: from mail.iot.bzh ([51.75.236.24]:60430 "EHLO mail.iot.bzh"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387591AbfIMIo2 (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Fri, 13 Sep 2019 04:44:28 -0400
Received: from [10.18.0.57] (laubervilliers-656-1-70-194.w82-127.abo.wanadoo.fr [82.127.244.194])
        by mail.iot.bzh (Postfix) with ESMTPSA id E84F640095;
        Fri, 13 Sep 2019 10:38:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iot.bzh; s=20180822;
        t=1568363904; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=WkeuTvKC1wSVq6VH7dfDjk9EUJeD/lzVIlGwmHnbhhU=;
        b=tuL+4HtzlsbtLEGpywjPCBvqEF+/VjZB2cdIo4BNAUTYqbARtFjEKObzPZWOYnYaVzwOh6
        HjsFWajdel7PKJOQvq73uNdXWKGgynPhHeK0NDCNEX7s5E/0vC/+kYpunQ6HxO2V/LHhPz
        +2FFid4wszvc7wR2SNgFNNwnmCcrKj0Y62989h2+/yu18/+Q54A0Cei5ZP6IAm4pyuZwNZ
        DsDFkVM22YmOaxjWVFCmsXkV+mXdNV+UkWzbm5fyNtZgnjyUSTF+RX/gltrfJ64wxxWjA/
        OC9vEEpK2j5s06PPUTY9A3CZLOROwgSIZAaY2lyj9ymeyeQyszGTzhFBUefqCw==
To:     linux-can@vger.kernel.org
From:   "Romain Forlot [IoT.bzh]" <romain.forlot@iot.bzh>
Subject: Signed signal value in CAN bus
Organization: IOTBZH
Message-ID: <2cea4753-c7b6-94a7-360f-30534591fd9f@iot.bzh>
Date:   Fri, 13 Sep 2019 10:38:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi everyone,

I have a question about signed numbers in CAN, but I try to handle sign 
of a signal's value whenever it is a signed value.

I would like to have something that works in any cases obviously but for 
what I found, signed value in CAN bus isn't standardized.

You can have:

  * signal on N-1 bits, with the subtracted bit representing the sign
  * either with 1's complement
  * or 2's complement.

You could have some bitfield not encoded within classics bytes but in 3 
or 13 bits by example, so it could complicate the computing of the 
signed value depending on the chosen method.

Best regards.

-- 
Romain Forlot - Embedded Engineer - IoT.bzh
romain.forlot@iot.bzh - www.iot.bzh - +33675142438

