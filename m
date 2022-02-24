Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25864C2DA7
	for <lists+linux-can@lfdr.de>; Thu, 24 Feb 2022 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbiBXNyw (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 24 Feb 2022 08:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiBXNyv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 24 Feb 2022 08:54:51 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1291B7197
        for <linux-can@vger.kernel.org>; Thu, 24 Feb 2022 05:54:21 -0800 (PST)
Received: from photo-meter.com ([62.157.68.154]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MyK9U-1oAfQs1oo0-00yiaK; Thu, 24 Feb 2022 14:54:18 +0100
Received: from [192.168.100.109] (MICHA.fritz.box [192.168.100.109])
        by photo-meter.com (Postfix) with ESMTP id 1E7963B08B7;
        Thu, 24 Feb 2022 14:52:10 +0100 (CET)
Message-ID: <7c5b3abc-0836-1840-a322-0c582abf9692@photo-meter.com>
Date:   Thu, 24 Feb 2022 14:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Reply-To: anochin@photo-meter.com
Content-Language: en-US
To:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
From:   Michael Anochin <anochin@photo-meter.com>
Subject: can: m_can: m_can_isr IR_ERR_ALL_30X
Organization: Czibula und Grundmann GmbH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VaI+8RSx5MQ9ix/cvQQaH3tqvzuogqOVHpIr3K2G7XNVW1Sn7d+
 3GM9ydxc5fryEjZnh3vlfKEW6TPJhciPiCEokHA3hNuJmtteHPGiHepAggARVI3YWQxoAT6
 A91cVfn9vFacKBEMo7+uMgoinP0gWLjm8BrmXw/ty2AX5b+UovZXODCesMcVudZyz7stnae
 T/LgSqPMrgLS6pvWG4AQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YwQ8wwE6qiY=:swdkd2dE7yJW6g1oTDlVN8
 ka7nEXNDyUh5mAn0HzjcHSqsve7r2s3hRDswxQhnruHZz087NKXrVUcVeul6xRpJMoe3Z0ASF
 nHAJoxXh4CeRs8gZR28l+gxfZuLWv62SSxKwDQCEUnnXwWem6C3fEUCI6kCD5SszO14Wqi8kC
 g9lIAbF7dL0VRWvgBW/M4YhRfvR6WdeMFcql1mb4poWfeCeAfL811X0YgjZxpYPpAOR6Es2d4
 /vEMKEnron1lc6eTRv52kHMJzNy+CQGA1U7KkXd1AlUSR+zqyd3SNJ20B1UxT2rHzQ2VTPlG/
 f2knQe0NZpRUhYrN4mZayH36dND/H+U+h8PC6Wxk9hzvUE0ngB9JpnSGWj6TqDLhkdJgJaRWA
 D3cmRAf/MWRmLZzVWykHcBmNe3C/7sWVFYCP8J9OlJH3zYsh8CSBYywxVT7dUQLAibVt0l55t
 +Q7Z9zIn6AJwaTA4f/hAxxKWzIeNmX1F0q2/LwhOXA/Uo0MhcK2bXRQMS9smhD586WQvJ/FYp
 ljdCvYbNOpLZM+CwfS5bOuJgMxuuUOXBp3PKN61ltCIeZDBDIeEqdzLMkYXBEdmrQ9Q345bfl
 dSBhsgfVVv5CewziMI/ROWgmiRbf6c6OP9ky/DMwA4tGvdjUMfL/wx4jY4BLZKBj8HNy3bT2D
 WfZZvVlLHH1ELQz4wGqlWHoafCVuTdx7il/otcDcuaO2IgZ0jPpHm7d6C+ONukFeM0bWQle9J
 gh+h1pGiaSTiCV3r
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org


In m_can_isr, in  rx handling the IR_ERR_ALL_30X is used without 
checking cdev->version > 30

if ((ir & IR_RF0N) || (ir & IR_ERR_ALL_30X))
{}

May be it is better to use IR_ERR_ALL_31X as mask for m_can_ver>30?

