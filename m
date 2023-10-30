Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45D67DB9AE
	for <lists+linux-can@lfdr.de>; Mon, 30 Oct 2023 13:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjJ3MM4 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 30 Oct 2023 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjJ3MMy (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 30 Oct 2023 08:12:54 -0400
X-Greylist: delayed 164 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Oct 2023 05:12:52 PDT
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34735C9
        for <linux-can@vger.kernel.org>; Mon, 30 Oct 2023 05:12:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1698667781; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=gw0U8pGHmvvWKYj95pglCVmgogPBrKrmne3EeODPwo0mX4uhq3uVJaExFeYH7A9Ri5
    gMkZVjg7+GV76QQamhWZEzl8aUwK5aHCbCFbHIhpMh0RU7405OCLuLsbRl0n5hAm69ar
    0rMn4rHne+lZtTX1zlB7xSAIWMiRxj2pS1Y2SXucFhScXhtcQmMeUs9inbb46uueTRK6
    wIREafRe4DIp6u9mAq94V21wlh1oWYQSXF+it3xaOxr9o9B8y4j41AA+nNucc39AsK+1
    /xp+ZGcmIg2qApF7J94Y9pm/NO26HPKtdV+4fim3fxCrg/JA6ydf+OVbc46BqvoWC5Mu
    NXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1698667781;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=drrAlRdzTKLmpUN502D+b7AZG4pADNnt8G+5zHkna0g=;
    b=Qbd4FICGYkmHdmQKP7kgJQX23cpjr+O4elJXTa3gkVjOQZaWuWfwSdiTzKqAskwgTQ
    QtzvDdHHK5cjaEe9WHLF7KJBHFm9UhS8rKNK97C6Jjcpdko2S+FPkdZ/OwUcO8aPblHs
    fOpStXB93laTkSLDPP4QG6xovMCbAZ6kNIi331eImnVN5Yf91CRLfvZi141B2RNA9PfV
    te+MXsB4UQonmg3q96J9Iz8ptOfvYWf18SO1o4x7sYXoMH2XagCir+0o+jGTi4NQyHfM
    2CGjXTxElX/Y59EPOtZViW5lKwK8vQgGKPfyaRdgnLHLM1aXGIt4/mJP0cN7vs6sVqvh
    vQ3A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1698667781;
    s=strato-dkim-0002; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=drrAlRdzTKLmpUN502D+b7AZG4pADNnt8G+5zHkna0g=;
    b=gUNB9nBxSL+PmUyzYVB/iHb4HncqoR44wb7dgBcJiF4hm0b7Qy+S+sh2VcYM+PzEjH
    3Ozf4FADovIyT2xUHCETZPk3gtwxa+2HGLPAf8YodAwXoCtWKMplpmQ1R9HJ692A5aoJ
    il/gO0iodO+owsJ01Xp7QZG2vGH6XPvl9b/P5//kc+I67ZcyU4iQpN8P2pf/Yhh+7it2
    Vu+OIbXSd4RqTsQ18jRQoq/WEiv1Y0rLgvWJuHP9G4pCx49IYSqPxEL9A/dfFRmWCOI1
    APgkIQIXKCFhk5DijINF5U51/2OsRkJ6yJbFlknIblcpzcmgGRw2HfW8nsx7/fP4KTyR
    nAVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1698667781;
    s=strato-dkim-0003; d=hartkopp.net;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=drrAlRdzTKLmpUN502D+b7AZG4pADNnt8G+5zHkna0g=;
    b=/+iTrKy5NpUj2UGUkSNAy68T6z5sFcSx+LcbISLB8ktGbDEPWuF7tlcT5DdcZkmXSz
    bjOZgKzyvo2OOb3bn6Cw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjG14FZxedJy6qgO1o3TMaFqTGVJiOM9vpw=="
Received: from [192.168.60.115]
    by smtp.strato.de (RZmta 49.9.1 DYNA|AUTH)
    with ESMTPSA id Kda39bz9UC9fDTm
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 30 Oct 2023 13:09:41 +0100 (CET)
Message-ID: <9bf2b7c9-fe80-4509-b023-c406f2fff994@hartkopp.net>
Date:   Mon, 30 Oct 2023 13:09:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] can: isotp: upgrade 5.15 LTS to latest 6.6 mainline code
 base
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, sashal@kernel.org,
        linux-can@vger.kernel.org, lukas.magel@posteo.net,
        patches@lists.linux.dev, maxime.jayat@mobile-devices.fr,
        mkl@pengutronix.de, michal.sojka@cvut.cz
References: <20231030113110.3404-1-socketcan@hartkopp.net>
 <2023103048-riverside-giving-e44d@gregkh>
From:   Oliver Hartkopp <socketcan@hartkopp.net>
In-Reply-To: <2023103048-riverside-giving-e44d@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello Greg,

On 30.10.23 12:38, Greg KH wrote:
> On Mon, Oct 30, 2023 at 12:31:10PM +0100, Oliver Hartkopp wrote:
>> The backport of commit 9c5df2f14ee3 ("can: isotp: isotp_ops: fix poll() to
>> not report false EPOLLOUT events") introduced a new regression where the
>> fix could potentially introduce new side effects.
>>
>> To reduce the risk of other unmet dependencies and missing fixes and checks
>> the latest mainline code base is ported back to the 5.15 LTS tree.
>>
>> To meet the former Linux 5.15 API these commits have been reverted:
>> f4b41f062c42 ("net: remove noblock parameter from skb_recv_datagram()")
>> 96a7457a14d9 ("can: skb: unify skb CAN frame identification helpers")
>> dc97391e6610 ("sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)")
>> 0145462fc802 ("can: isotp: isotp_recvmsg(): use sock_recv_cmsgs() to get SOCK_RXQ_OVFL infos")
>>
>> New features and communication stability measures:
>> 9f39d36530e5 ("can: isotp: add support for transmission without flow control")
>> 96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
>> 4b7fe92c0690 ("can: isotp: add local echo tx processing for consecutive frames")
>> 530e0d46c613 ("can: isotp: set default value for N_As to 50 micro seconds")
> 
> Please send these as individual patches, reverts and then the new ones
> added, not as one huge commit that we can't review properly at all.

That would be around 20 patches including fixes and fixes of fixes of 
fixes. For that reason I simply copied the 6.6 code and made the code 
work in 5.x by adapting it to the old 5.x kernel APIs.

E.g. the diff from the new 5.15 and the 6.6 code is just this:

$ diff -U 2 isotp.c-5.15-new isotp.c-6.6
--- isotp.c-5.15-new	2023-10-29 15:41:39.770567182 +0100
+++ isotp.c-6.6	2023-10-28 22:07:21.293444651 +0200
@@ -695,5 +695,5 @@
  			isotp_rcv_sf(sk, cf, SF_PCI_SZ4 + ae, skb, sf_dl);
  		} else {
-			if (skb->len == CANFD_MTU) {
+			if (can_is_canfd_skb(skb)) {
  				/* We have a CAN FD frame and CAN_DL is greater than 8:
  				 * Only frames with the SF_DL == 0 ESC value are valid.
@@ -1130,5 +1130,4 @@
  	struct sk_buff *skb;
  	struct isotp_sock *so = isotp_sk(sk);
-	int noblock = flags & MSG_DONTWAIT;
  	int ret = 0;

@@ -1139,6 +1138,5 @@
  		return -EADDRNOTAVAIL;

-	flags &= ~MSG_DONTWAIT;
-	skb = skb_recv_datagram(sk, flags, noblock, &ret);
+	skb = skb_recv_datagram(sk, flags, &ret);
  	if (!skb)
  		return ret;
@@ -1153,5 +1151,5 @@
  		goto out_err;

-	sock_recv_timestamp(msg, sk, skb);
+	sock_recv_cmsgs(msg, sk, skb);

  	if (msg->msg_name) {
@@ -1692,5 +1690,4 @@
  	.recvmsg = isotp_recvmsg,
  	.mmap = sock_no_mmap,
-	.sendpage = sock_no_sendpage,
  };


Of course I could split all the fixes and improvements into new patches 
that omit the API changes. But is it worth the effort when we end up 
with the 6.6 code using the old API?

> But why just 5.15?  What about 6.1.y and 6.5.y?

I have posted 5.10 and 5.15 for now.
6.1 would be only this patch
96d1c81e6a04 ("can: isotp: add module parameter for maximum pdu size")
I can also provide.

6.5 is up to date with the latest 6.6

Best regards,
Oliver
