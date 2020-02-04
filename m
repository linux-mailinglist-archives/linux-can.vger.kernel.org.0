Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01D03151ECF
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2020 17:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBDQ7Z (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 4 Feb 2020 11:59:25 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.23]:19921 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgBDQ7Z (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 4 Feb 2020 11:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1580835563;
        s=strato-dkim-0002; d=hartkopp.net;
        h=In-Reply-To:Date:Message-ID:Cc:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=gZhZtQSq5xFn5nWbxwj1Q9cB6N+7LXg0pi3Mo1fumBU=;
        b=Bo0yXrP46o5Ho7q2HOOQNP0uP4ggxrLWswih1ZwanFshW6zlETl9fyZRD5PqkV8Inp
        hqSqVriTgSDNcuAzqYEYWlduztPKF0jlynKKa08Yg8sb7AKQNsaKt6/c9FJaQsY4zQJw
        dvDTBL6PJQVQv2lO6A+MXEqlFdatvjyf9PoxK147F/FtiAxCZAsNES/SI8orgrTFKobl
        zyzoHxnziZRD0QXN3ZtuH48KFwEL6eaC4c+pjxDLrucxLrmxu8ghYnfR+Dh1weOEf7UO
        D63GeaELcstXDjPIbKRFW/FL7giDpDoXdfnew8+D07FS0LUeDn96mKD2at2/X0dcDTCk
        rksA==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3PMaViOoLMJUsh6k0go"
X-RZG-CLASS-ID: mo00
Received: from [192.168.1.177]
        by smtp.strato.de (RZmta 46.1.12 DYNA|AUTH)
        with ESMTPSA id g084e8w14GxJDFu
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 4 Feb 2020 17:59:19 +0100 (CET)
Subject: can-utils update for Debian
To:     Alexander Gerasiov <gq@debian.org>
References: <b6496d06-00ad-49e9-04bb-0062b19857dd@hartkopp.net>
 <20160925230257.68f3b937@brick.gerasiov.net>
 <ee55bc09-f60a-a637-e0d4-ff4aa69c9df1@hartkopp.net>
 <20160927110637.3d7f7ece@brick.gerasiov.net>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
Cc:     linux-can <linux-can@vger.kernel.org>
Message-ID: <08b5fb48-bb69-0a34-3851-cb213d9b9f15@hartkopp.net>
Date:   Tue, 4 Feb 2020 17:59:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20160927110637.3d7f7ece@brick.gerasiov.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Alexander,

we have a new tag v2020.02.04 which is worth to make it a Debian package 
after nearly two years.

Relevant things that have changed:

- SPDX license compliance and cleanup
- new tools for CAN J1939 (since Linux 5.4)
- remove bridging functionality from candump

and of course several updates and enhancements.

We already had people that asked for an update of the tag to get an 
update on Debian ;-)

There is also another 2020.x tag - but the latest 2020.02.04 has a late 
fix for isotpsniffer.

Many thanks and best regards,
Oliver

ps. I remember your attempt to create man pages for the can-utils. We 
should probably plan this for the next but one release.
