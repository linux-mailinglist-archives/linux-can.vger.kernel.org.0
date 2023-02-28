Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56406A6087
	for <lists+linux-can@lfdr.de>; Tue, 28 Feb 2023 21:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjB1Um6 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Feb 2023 15:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjB1Um5 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Feb 2023 15:42:57 -0500
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA6D34F52
        for <linux-can@vger.kernel.org>; Tue, 28 Feb 2023 12:42:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1677616966; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GeCP424wrm7ImZzpp0+iM4tV3ge4ZWmR9mYGYGDnG9KnFB91gjFBr8ItBQ2XmmY030
    s4IHb8SK7sstDa2F0dNh7iYemf4rAvIP8KOgR8O09bxd7leDu1HHTQPVe+RmHhR5RGSq
    HRZ73yVR0LwmJjDLt5nA1ukuM7WSCJ3yJoOVjTabl/rAeePw+vmlidvszrUOjbBcGC8B
    4pqtx/+jEFZGFJFbEeo0GOSy5FnyOPHBJOD+cEhQ79eeNnpA92WDz2rwtlFsEpxkela2
    NyMkNwdm9bNPu5f1DINhlSUSo8ZB6EiF1OzCo3f5FQXv0N+6kG6aUQFqUxB468Qtd9Nr
    N48g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1677616966;
    s=strato-dkim-0002; d=strato.com;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=Cp9AkkC/o9drd+cHOkHXHDX7CE5e8ylHz/mj4kwk8vw=;
    b=M15duxqHn13//E2X1JPeKMFBXTb14UrPJWoyZMESAakRWN4lNKKhvCd3RqE+MJ1OBy
    8SwH04WeMwNr3ev8uRbmXd7GEJtYHMJKJRadU0txsYcMKvhdyGcbvjCvvgciwTEcJunJ
    6NoVj/2k3C9uQM7hgM7+oQ5hzv/jaf3ouOT15Vi8SjtcVwUzOj4o/tZF4mUE8e6OHMJz
    CbEkORdICbHplaanuzyMi9pWiPjt1mAxUThic77AclMmtcpJAUqZfx0utQjkZUOt0UON
    COebU8IoAvynhSPBUUtjEo/Gt7vCaHZgQ7l0YH7aHF7IyuzwMagboSpqs2QTmXZM2Rc5
    ru2A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1677616966;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Subject:From:Cc:To:Date:Message-ID:Cc:Date:From:Subject:Sender;
    bh=Cp9AkkC/o9drd+cHOkHXHDX7CE5e8ylHz/mj4kwk8vw=;
    b=alheTWr6TQFuyIs1g6VwNJs1b33INN6P9yU+5tMy3W+Htdaxfy1IzJRPrA1Mcr5sMS
    vKQNgNzyX4xsnFnxi25rUpL16I2MOQGDJMCp4jNO9l60xfj7CBXc8aOG2xnVP8n5btWz
    fXaCZOQMGU2XLJMLOrfoAxf0/2EqfZpodPqeVfUT0vJRVM8z7mxhA2P9Pep13kwL5xz+
    fviVCNnTrJsJlVzXDuarC2GDqDrO5muHBAS2eOUbVgiVwv8QKOtNzCNRe4QcGuraPjbY
    znSwJumsjkM4naHaSaibVeNfZ/rJ1Z2A7o6kkDGbeRI7TR9Nt6XglXBcseGJCL1xj9ew
    zsaA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1qCHSa1GLptZHusl129OHEdFq0USEbDUQnQ=="
Received: from [IPV6:2a00:6020:4a8e:5000::923]
    by smtp.strato.de (RZmta 49.3.0 AUTH)
    with ESMTPSA id c675b3z1SKgk1CO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 28 Feb 2023 21:42:46 +0100 (CET)
Message-ID: <b53a04a2-ba1f-3858-84c1-d3eb3301ae15@hartkopp.net>
Date:   Tue, 28 Feb 2023 21:42:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To:     Michal Sojka <michal.sojka@cvut.cz>
Cc:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Subject: please re-send [RFC PATCH] can: isotp: fix poll() to not report false
 positive EPOLLOUT events
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hi Michal,

I'm currently testing some isotp traffic with your 'poll' patch but 
unfortunately I did not see this mail in my in-box:

https://lore.kernel.org/linux-can/20230224010659.48420-1-michal.sojka@cvut.cz/T/#u

It is visible on the mail archive but obviously something went wrong on 
my mail server side ¯\_(ツ)_/¯

Can you please re-send your patch, so that I can comment inside?

Many thanks,
Oliver
