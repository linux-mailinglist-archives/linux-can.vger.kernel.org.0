Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD6E68E21B
	for <lists+linux-can@lfdr.de>; Tue,  7 Feb 2023 21:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjBGUpg (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 7 Feb 2023 15:45:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBGUpf (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 7 Feb 2023 15:45:35 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF81420073
        for <linux-can@vger.kernel.org>; Tue,  7 Feb 2023 12:45:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1675802726; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=FAhqQV6mRdociXs+VqaQjQNbsULUKxcAOrqhHWZH9elA9bo6GUrlNlAQbYgo+VxhWA
    Y3MIkHHNpqvr6LCBBNoObnyzTIog5018ja3J5NFg/zQQYMpMSks9Kvt8PgHjHDJ38Rfp
    ch05VDULqoxinuG2YUEKSlxdMWVuB7Jd44b7HsWiu/chp9bol53eHkQFb9oCWwPoQU9F
    2O4i72KsmAdhJM31u/0tzihOtRCdmnZK1Qwozs8OhO6LXknoHGnYT1unr8ZFbHjtPKk2
    areIVbo9FRyQe5V96gnyOOBpugtvjGL/6UlcQytIqoBkYjKFOZZCl0IyTS8ftNdhEL3C
    gGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1675802726;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=YBQg/JWcNHCl0L3SPkibh2j0uu4EfC1Czsc/bjZ49+4=;
    b=Umq1ppnhL/BnFe8hqSownsNvfymI7OOfhFO0pzTFV6ttPMjBLCXMW+sGvfodaZTFOu
    h5DA8KDfeFLuCyI8+vSYyGx67u+KTp6UXlMuqaHEfj2eZv3klLxv6wamUvDAkItku5bn
    Irs/3C/XpRxQn5FtgjbfjQ+nJVG5RCbOWTvrAogZyOWafKg1M2w7hSnMwQ0S1fu7Hrkl
    s2OqDAnkso4khKbgrKtVM78/MmDw8mZAeY6rSHmmshBMVyuAkxykzZ6JTvurzDMANiS7
    0KLXIAirz7NF8zGz7vHJPjndeKUXiAKMjr4BMrCSjbchgORiTlTVn8LYaR75aE0trWT0
    BMqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1675802726;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=YBQg/JWcNHCl0L3SPkibh2j0uu4EfC1Czsc/bjZ49+4=;
    b=BkZt3ycoEr2XLv6PSodyapRrLQ7CDaj5MdKgKTwl77u5D9Z4ju1GbA4ohKQcCHictH
    OCUyrIFw3HaedBOCMcAbIkqh9GssYqtBxcRDYR0An71L8wJAZxPepJ9mTKjpZsxmEGLe
    83QJjBVIm7OXfOnF7cvs2QOE6BC816WHxxzX70T5FRlEhu9YaDBosI+sbekkBkYxoji3
    P/fss486Y2bPAjpGm7SqUa+vDUI5kyGWk32/4uXgxHvaxA+vvHq8x7VeSHGXNbTKef9X
    Hq7y14ygGa/fkU106ckoWjiLkKjG99iGe3Y3otdFIKilrQNabpQPY4UTHMjQjLrFHLka
    ttKQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USENNQlSw=="
Received: from [IPV6:2a00:6020:4a8e:5000::a0a]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id x84a76z17KjP1wi
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 7 Feb 2023 21:45:25 +0100 (CET)
Message-ID: <94e3c5bc-6af9-f240-86fa-2b780a58533f@hartkopp.net>
Date:   Tue, 7 Feb 2023 21:45:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Content-Language: en-US
To:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>,
        Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>,
        linux-can <linux-can@vger.kernel.org>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        hsweeten@visionengravers.com
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Subject: xlinix_can: bug when sending two RTR frames
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi xilinx_can maintainers,

Hartley Sweeten reported a bug when sending RTR frames with the 
xilinx_can driver here:

https://github.com/linux-can/can-utils/issues/405#

The problem: When sending a single RTR frame (e.g. with 'cansend can0 
001#R') nothing happens.

Only after sending a *second* RTR frame with 'cansend can0 001#R' the 
two (pending) RTR-frames are sent directly after each other.

This faulty behavior of RTR frame sending is independent of the time gap 
between the two cansend attempts.

Best regards,
Oliver
