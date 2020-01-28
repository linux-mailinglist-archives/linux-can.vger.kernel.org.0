Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7EA14BEE9
	for <lists+linux-can@lfdr.de>; Tue, 28 Jan 2020 18:50:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgA1RuV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 28 Jan 2020 12:50:21 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.22]:15437 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgA1RuU (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 28 Jan 2020 12:50:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580233819;
        s=strato-dkim-0002; d=hartkopp.net;
        h=Date:Message-ID:Subject:From:To:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=ZxWID2W5P8b9MAcRxowFP2OC3Jd3xfQJkkW9zZZZyEI=;
        b=mX3++FUenIVVsa6RdNS2b9EyjM0nc13gofxPMaFJkHihulhk9Ity9EhZlsrdDpu96M
        1Cg4NNtin0Abax5g8j2l7T15I+Sgewa26VPcUWzRmw0xJvC6Wrxo0rwJcIazipQF6KO8
        PAcrSHU4IBYc+70HBjfraS1mUddbZkiDSqb9+mg/qte28ZWg+J26UXMU6hLZhjeuqg+7
        chC2h+uoH38DXJSB9mpU3MZ+zA9HJHtyCYVRA2NyfOB5jqXiB/m3vKHGyhep2WVD4IXn
        UHzW+bPfc/GikSXKMWSD6b1s3uyF9zk5wBWCH8+Uo3qzESk1yAWpBI6ecyRVz4gjuQSZ
        PPSQ==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJU8h5lk0M"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.7 DYNA|AUTH)
        with ESMTPSA id R0798bw0SHoIEoa
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate)
        for <linux-can@vger.kernel.org>;
        Tue, 28 Jan 2020 18:50:18 +0100 (CET)
To:     linux-can <linux-can@vger.kernel.org>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Subject: Tutorial to use the M_CAN IP cores with a STM32MP157A-DK1 dev kit
Message-ID: <392f401a-f785-094d-2043-37197312c08c@hartkopp.net>
Date:   Tue, 28 Jan 2020 18:50:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

To whom it may concern ...

I was searching for a development kit that allows SocketCAN testing with 
a Bosch M_CAN IP core.

The STM32MP157A-DK1 dev kit contains a M_CAN and a MTT_CAN (time 
triggered) IP core but has no CAN transceivers and no device tree 
configuration to access the CAN rx/tx lines of the two CAN interfaces.

The tutorial can be found here:

https://github.com/hartkopp/M_CAN-on-STM32MP157A-DK1

Have fun,
Oliver
