Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E583D7171BA
	for <lists+linux-can@lfdr.de>; Wed, 31 May 2023 01:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjE3XbB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 30 May 2023 19:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjE3Xa6 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 30 May 2023 19:30:58 -0400
X-Greylist: delayed 1809 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 16:30:56 PDT
Received: from smtpx.fel.cvut.cz (smtpx.feld.cvut.cz [147.32.210.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163859C
        for <linux-can@vger.kernel.org>; Tue, 30 May 2023 16:30:55 -0700 (PDT)
Received: from localhost (styx2022 [192.168.200.17])
        by smtpx.fel.cvut.cz (Postfix) with ESMTP id A2A91198E5
        for <linux-can@vger.kernel.org>; Wed, 31 May 2023 01:30:54 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
        by localhost (styx2022.feld.cvut.cz [192.168.200.17]) (amavisd-new, port 10060)
        with ESMTP id cSVn1FmZcssd for <linux-can@vger.kernel.org>;
        Wed, 31 May 2023 01:30:53 +0200 (CEST)
Received: by smtpx.fel.cvut.cz (Postfix, from userid 0)
        id F1CA2198E4; Wed, 31 May 2023 01:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
        s=felmail; t=1685489452;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; h=Date:From:From;
        b=TGD2KIlu5RSySOWBKEKBp4xl83zTExu9w8iEuHeGhwkoDrgqL3xfs7rFihN64M0G+
         CZcCd350Z11lML//UKXww4rqN4P/f79BPi0LHTHVKe6VrngjrnHc7MFqVqW0aWtDbD
         KuVm8cCQH2WMmc2/VHcdSegt0cdNSwk6j2MYEtJPC51dmOiU5ynTLwL57lo2KcAKgR
         +hkhia4XdIJxzY8Q3krBQpPLHnHx9jFHuefUo6LXtnCU32UNsoHUGR+3iKMWIKeEWf
         zpu5JKxM0PEMAiCFqZuyN3Dckwg4uSv8MCN1Mae1MNbBRp7Mt4GJWilg51otbPch57
         LYdRp6hA9yAng==
Message-Id: <20230530233052.F1CA2198E4@smtpx.fel.cvut.cz>
Date:   Wed, 31 May 2023 01:30:52 +0200 (CEST)
From:   root <root@fel.cvut.cz>
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,EMPTY_MESSAGE,MISSING_HEADERS,MISSING_SUBJECT,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  0.0 URIBL_BLOCKED ADMINISTRATOR NOTICE: The query to URIBL was
        *      blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [URIs: cvut.cz]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5001]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.0 MISSING_HEADERS Missing To: header
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.3 EMPTY_MESSAGE Message appears to have no textual parts
        *  1.8 MISSING_SUBJECT Missing Subject: header
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

