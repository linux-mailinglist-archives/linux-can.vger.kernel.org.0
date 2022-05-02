Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD21F51741E
	for <lists+linux-can@lfdr.de>; Mon,  2 May 2022 18:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386294AbiEBQWM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 2 May 2022 12:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355099AbiEBQWK (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 2 May 2022 12:22:10 -0400
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E57E0C4
        for <linux-can@vger.kernel.org>; Mon,  2 May 2022 09:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1651508316;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=xq19Cp/YMOxvIi/lsTQvZQavADouv/WiLTAnJYZSaI8=;
    b=YPOWqctgt1//72dzlCy3XnYWlv4LZHeF7h3BQPr6VLEvLqPui19/a4xlbM1wT+9rUe
    e/7R9fzDVzbC+FpMpeYjiAvdIaKR/OxgQuoxNjFzFi7JFRvX4R/vnRCZI45AqKgPXo8j
    MKLCNTNoLHyNOZTe4DzNI9SGGUIabrh76svmZVTvXlRfacCZALE5pmQ9D4ZY6hTOfx0z
    66UqEPlM2N0Z4dWKExhmOP1BOO3Ud1g7O24Ve417yX2ZGSOhzeuKRQ3iLr4GZiafdkcB
    29avHkK1DKl9PUaZOixeYGh+Ru83g9tckYkxY4E+7A35HJjHRmckBlL+s+x4E24xZwXK
    qzEA==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusx3hdBqPeOug2krLFRKxw=="
X-RZG-CLASS-ID: mo00
Received: from [IPV6:2a00:6020:1cff:5b04::b82]
    by smtp.strato.de (RZmta 47.42.2 AUTH)
    with ESMTPSA id 4544c9y42GIZYzC
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 2 May 2022 18:18:35 +0200 (CEST)
Message-ID: <f298d14f-57a7-9ef2-469c-205cf697e2c4@hartkopp.net>
Date:   Mon, 2 May 2022 18:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [RFC]: can-next 2022-05-02: CAN_RAW: support SO_TXTIME/SCM_TXTIME
Content-Language: en-US
To:     Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc:     kernel@pengutronix.de
References: <20220502091946.1916211-1-mkl@pengutronix.de>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <20220502091946.1916211-1-mkl@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


On 02.05.22 11:19, Marc Kleine-Budde wrote:

> this series add support for SO_TXTIME/SCM_TXTIME to the CAN_RAW
> protocol. This makes it possible to use the ETF scheduler.

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>

Thanks Marc!
