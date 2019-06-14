Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E93445A0D
	for <lists+linux-can@lfdr.de>; Fri, 14 Jun 2019 12:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727059AbfFNKKV (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 14 Jun 2019 06:10:21 -0400
Received: from cpanel4.indieserve.net ([199.212.143.9]:41046 "EHLO
        plantingparadise.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbfFNKKV (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 14 Jun 2019 06:10:21 -0400
Received: from cpef81d0f814063-cmf81d0f814060.cpe.net.cable.rogers.com ([174.114.57.56]:60778 helo=localhost.localdomain)
        by cpanel4.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1hbjA3-00047b-3t
        for linux-can@vger.kernel.org; Fri, 14 Jun 2019 06:10:19 -0400
Date:   Fri, 14 Jun 2019 06:10:17 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     linux-can@vger.kernel.org
Subject: missing files/dirs in MAINTAINERS CAN entries
Message-ID: <alpine.LFD.2.21.1906140559150.12857@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-OutGoing-Spam-Status: No, score=-0.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel4.indieserve.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel4.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel4.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


  at a glance, seems to be a few omissions or lack of specificity in
the MAINTAINERS file for CAN-related content in the two sections:

  - CAN NETWORK DRIVERS
  - CAN NETWORK LAYER

  first, there's no specific CAN listing for include/net/netns/can.h,
it's just listed as part of general networking.

  also, there are unmentioned entries under include/linux/can/,
including:

  led.h
  rx-offload.h
  skb.h

and no entry for include/linux/can/dev/ specifically (which contains
the single header file peak_canfd.h).

  oh, and no mention of include/uapi/linux/can/vxcan.h.

just thought i'd mention this if it was of any interest.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                         http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
